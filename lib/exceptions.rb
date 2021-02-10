class LowBalanceError < StandardError
  attr_reader :msg

  def initialize
    @msg = 'Not enough money'
    super(msg)
  end
end

class MaximumBalanceError < StandardError
  attr_reader :msg

  def initialize
    @msg = 'Balance over limit'
    super(msg)
  end
end
