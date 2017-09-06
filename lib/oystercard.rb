require 'journey'

class OysterCard
  attr_reader :balance, :entry_station, :journey, :in_journey, :check

  CARD_LIMIT = 90
  @@min_fare = 1
  @@penalty_fare = 6

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    raise "OVER YOUR £#{CARD_LIMIT} CARD LIMIT" if (amount + @balance) > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'BELOW LIMIT, TOP UP' if @balance < 1
    @entry_station = entry_station
    self.in_journey ? @balance -= @@penalty_fare : @balance -= @@min_fare
    journey.start_journey(@entry_station)
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    self.in_journey ? @balance -= @@min_fare : @balance -= @@penalty_fare
    @journey.journey_finish(@exit_station)
    @check = false
  end

  def in_journey
    @journey.entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
