require 'oyster_card.rb'

describe Oystercard do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

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
    it 'will not touch if balance is insufficient' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds to travel'
    end

    context 'Topped up and touched into station' do
      before do
        subject.top_up(10)
        subject.touch_in(entry_station)
      end

      it 'records when the card has been touched in' do
        expect(subject.in_journey?).to eq true
      end
      it 'records last station I touched in at' do
        expect(subject.entry_station).to eq entry_station
      end
    end
  end

  describe '#touch_out' do
    context 'it tops up, touches in and touches out' do
      before do
        subject.top_up(10)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end

      it 'records when the card has been touched out' do
        expect(subject.in_journey?).to eq false
      end

      it 'records forgets the last station I touched in at' do
        expect(subject.entry_station).to eq false
      end

      it 'deducts the costs of a fare from balance upon touching out' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::FARE)
      end

      it 'records last station I touched out at' do
        expect(subject.exit_station).to eq exit_station
      end
    end
  end

  describe '#in_journey?' do
    context 'it tops up and touches in' do
      before do
        subject.top_up(10)
        subject.touch_in(entry_station)
      end

      it 'returns true when card has been touched in' do
        expect(subject.in_journey?).to eq true
      end
      it 'returns false when card has been touched out' do
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq false
      end
    end
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'records the entry and exit station of each journey as a hash' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end
end
