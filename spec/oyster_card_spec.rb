require 'oyster_card.rb'

describe OysterCard do

# NameError: uninitialized constant OysterCard
# ./spec/oyster_card_spec.rb:1:in `<top (required)>'
describe '#balance'
  it 'tells customer whether the card has a balance' do
   expect(subject.balance).to eq 0  
  end

end
