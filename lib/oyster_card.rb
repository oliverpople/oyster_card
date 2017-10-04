class Oystercard
  attr_accessor :balance, :entry_station

  FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'This is above maximum balance!' if (amount + @balance) > 90
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient funds to travel' if @balance < 1
    @entry_station = entry_station
  end

  def touch_out
    @balance -= FARE
    @entry_station = false
  end

  def in_journey?
    !!entry_station
  end



end
