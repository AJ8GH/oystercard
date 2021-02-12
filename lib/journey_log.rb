class JourneyLog
  def journeys
    journey_history.dup
  end

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_history = []
    @current_journey = nil
  end

  def start(station)
    self.current_journey = journey_class.new(entry_station: station)
  end

  def finish(station)
    current_journey.exit_station = station
    journey_history << current_journey
  end

  private

  attr_reader :journey_history, :journey_class
  attr_accessor :current_journey
end
