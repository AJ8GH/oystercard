require 'journey'

describe Journey do
  let(:entry_station) { instance_double(Station, :entry_station, zone: 2) }
  let(:exit_station) { instance_double(Station, :exit_station, zone: 1) }
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



  describe '#fare' do
    context 'when journey is complete deduct minimum fares' do
      it 'is minimum fare' do
        complete_journey = Journey.new(:entry_station => entry_station, :exit_station => exit_station)
        expect(complete_journey.fare).to be Oystercard::MINIMUM_FARE
      end

      it 'when journey is incomple at touch_in deduct PENALTY' do
        incomplete_journey = Journey.new(:entry_station => entry_station)
        expect(incomplete_journey.fare).to eq Journey::PENALTY
      end
    end
  end
end
