require 'journey_log'

describe JourneyLog do
  let(:journey_class) { class_double(Journey, :journey_class, new: new_journey) }
  let(:new_journey) { instance_double(Journey, :new_journey, :exit_station= => exit_station) }
  let(:entry_station) { instance_double(Station, :entry_station) }
  let(:exit_station) { instance_double(Station, :exit_station) }
  subject { described_class.new(journey_class) }

  describe '#journeys' do
    it 'is empty by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#start' do
    it 'creates a new journey' do
      expect(subject.start(entry_station)).to be new_journey
    end
  end

  describe '#finish' do
    context 'when current journey is not nil' do
      it 'completes current journey' do
        expect(new_journey).to receive(:exit_station=).with(exit_station)
        subject.start(entry_station); subject.finish(exit_station)
      end

      it 'adds current journey to journeys' do
        subject.start(entry_station)
        subject.finish(exit_station)
        expect(subject.journeys).not_to be_empty
      end
    end

    context 'when current journey is nil' do
      it 'creates a new incomplete journey' do
        subject.finish(exit_station)
        expect(subject.journeys.last).to be new_journey
      end
    end
  end
end
