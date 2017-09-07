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

  def fare(entry_zone, exit_zone)
    return 1 if entry_zone == exit_zone
    return 2 if ((entry_zone) - (exit_zone)).abs == 1
    return 3 if ((entry_zone) - (exit_zone)).abs == 2
    return 4 if ((entry_zone) - (exit_zone)).abs == 3
    return 5 if ((entry_zone) - (exit_zone)).abs == 4
  end

  def top_up(amount)
    raise "OVER £#{CARD_LIMIT} LIMIT" if (amount + @balance) > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'BELOW LIMIT' if @balance < 1
    @entry_station = entry_station
    @balance -= @journey_log.entry_station != nil ? @@penalty_fare : @@min_fare
    @journey_log.start(@entry_station)
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @balance -= @journey_log.entry_station == nil ? @@penalty_fare : fare(@entry_station.zone, @exit_station.zone)
    @journey_log.finish(@exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
