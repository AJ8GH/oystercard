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
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
  end



  private

  attr_writer :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
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

end
