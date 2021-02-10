class Oystercard
  attr_reader :balance, :limit, :entry_station, :exit_station, :journeys

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def top_up(amount)
    raise MaximumBalanceError if over_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    raise LowBalanceError if low_balance?
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    self.exit_station = station
    save_journey
    self.entry_station = nil
  end

  def journey_history
    journeys.map { |journey| journey.values.join(' to ') }.join("\n")
  end

  private

  attr_writer :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def over_limit?(amount)
    amount + balance > limit
  end

  def deduct(amount)
    self.balance -= amount
  end

  def in_journey?
    !!entry_station
  end

  def save_journey
    journeys << {entry_station: entry_station.name, exit_station: exit_station.name}
  end
end
