class OysterCard

  attr_accessor :balance, :in_use

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "This is above maximum balance!" if (amount + @balance) > 90
    @balance += amount
  end

  def deduct(cost)
    @balance -= cost
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end
