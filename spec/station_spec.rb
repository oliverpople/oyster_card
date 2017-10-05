require './lib/station.rb'

describe Station do

subject{described_class.new("Old street", 1)}

  describe '#name' do
    it "knows station's name" do
      expect(subject.name).to eq("Old street")
    end
  end
  describe '#zone' do
    it "knows station's zone" do
      expect(subject.zone).to eq(1)
    end
  end
end
