require_relative 'journey'
require_relative 'journey_log'

class OysterCard
  attr_reader :balance, :entry_station, :exit_station, :journey_log

  CARD_LIMIT = 90
  @@min_fare = 1
  @@penalty_fare = 6

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "OVER YOUR £#{CARD_LIMIT} CARD LIMIT" if (amount + @balance) > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'BELOW LIMIT, TOP UP' if @balance < 1
    @entry_station = entry_station
    @balance -= @journey_log.entry_station != nil ? @@penalty_fare : @@min_fare
    @journey_log.start(@entry_station)
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @balance -= @journey_log.entry_station ? @@min_fare : @@penalty_fare
    @journey_log.finish(@exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
