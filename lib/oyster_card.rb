class Oystercard
  attr_accessor :balance, :entry_station, :exit_station, :journeys

  FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise 'This is above maximum balance!' if (amount + @balance) > 90
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient funds to travel' if @balance < 1
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @balance -= FARE
    @exit_station = exit_station
    @journeys << {entry_station: entry_station, exit_station: exit_station} 
    @entry_station = false
  end

  def in_journey?
    !!entry_station
  end
end
