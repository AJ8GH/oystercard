require 'station'

describe Station do

subject { described_class.new("Kings Cross", 1) }

 it 'should return the station name' do
  expect(subject.name).to eq "Kings Cross"
 end

 it 'should return the zone' do
  expect(subject.zone).to eq 1
 end

end
