require 'oyster_card.rb'

describe Oystercard do

let(:entry_station) {double(:entry_station)}

  describe '#balance' do
    it 'tells customer whether the card has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top up' do
    it 'should top up the card' do
      val = rand(90)
      subject.top_up(val)
      expect(subject.balance).to eq val
    end
    it "shouldn't let an oyster card top up more than 90" do
      expect { subject.top_up(91) }.to raise_error('This is above maximum balance!')
    end
  end

  describe '#touch_in' do
    it 'records when the card has been touched in' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'will not touch if balance is insufficient' do
      expect{ subject.touch_in(entry_station) }.to raise_error 'Insufficient funds to travel'
    end

    it 'records last station I touched in at' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

  end

  describe '#touch_out' do
    it 'records when the card has been touched out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it 'records forgets the last station I touched in at' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.entry_station).to eq false
    end


    it 'deducts the costs of a fare from balance upon touching out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::FARE)
    end
  end

  describe '#in_journey?' do
    it 'returns true when card has been touched in' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'returns false when card has been touched out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end
end
