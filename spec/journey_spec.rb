require 'journey'

describe Journey do
  let(:entry_station) { instance_double(Station, :entry_station) }
  let(:exit_station) { instance_double(Station, :exit_station) }
  subject { described_class.new(entry_station: entry_station) }

  context ' when initialized with entry station' do
    it 'is incomplete' do
      expect(subject).not_to be_complete
    end

    it 'has an entry station' do
      expect(subject.entry_station).to be entry_station
    end
  end

  context 'when there is entry and exit station' do
    it 'is complete' do
      subject.exit_station = exit_station
      expect(subject).to be_complete
    end
  end
end
