class Oystercard
  attr_reader :balance, :limit, :entry_station

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def top_up(amount)
    top_up_limit_guard(amount)
    self.balance += amount
  end

  def touch_in(station)
    low_balance_guard
    update_journey_status
    self.entry_station = station
  end

  def touch_out
    deduct(1)
    update_journey_status
  end

  private

  attr_writer :balance, :entry_station
  attr_accessor :in_journey

  alias :in_journey? :in_journey
  undef :in_journey

  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
    @in_journey = false
    @entry_station = nil
  end

  def low_balance_guard
    fail 'Not enough money' if low_balance?
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def top_up_limit_guard(amount)
    fail "#{amount} is over limit!" if over_limit?(amount)
  end

  def over_limit?(amount)
    amount + balance > limit
  end

  def deduct(amount)
    self.balance -= amount
  end

  def update_journey_status
    if in_journey?
      self.in_journey = false
    else
      self.in_journey = true
    end
  end
end
