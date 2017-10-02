require 'oyster_card.rb'

describe OysterCard do

# NameError: uninitialized constant OysterCard
# ./spec/oyster_card_spec.rb:1:in `<top (required)>'

  describe '#balance' do
    it 'tells customer whether the card has a balance' do
     expect(subject.balance).to eq 0
    end
  end

  describe '#top up' do

    it 'should top up the card' do
      val = rand(100)
      subject.top_up(val)
      expect(subject.balance).to eq val
    end

  end

end
