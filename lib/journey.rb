require_relative 'oystercard'
require_relative 'journey_log'

class Journey
  attr_accessor :journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = { journey_start: nil, journey_end: nil }
  end

  def start_journey(entry_station)

    @journey[:journey_start] = entry_station

  end

  def journey_finish(exit_station)
    @exit_station = exit_station
    @journey[:journey_end] = exit_station
    # @journey_log.log(@journey)
  end


end
