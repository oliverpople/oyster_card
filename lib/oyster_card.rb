class Oystercard
  attr_accessor :balance, :in_use

  FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'This is above maximum balance!' if (amount + @balance) > 90
    @balance += amount
  end

  def touch_in
    raise 'Insufficient funds to travel' if @balance < 1
    @in_use = true
  end

  def touch_out
    @in_use = false
    @balance -= FARE
  end

  def in_journey?
    @in_use
  end
end
