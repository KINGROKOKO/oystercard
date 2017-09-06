require_relative 'oystercard'
require_relative 'journey_log'

class Journey
  attr_accessor :journey_history
  attr_reader :entry_station, :exit_station, :in_journey

  def initialize
    @journey_log = JourneyLog.new
    # @journey_history = []
    @journey = { journey_start: nil, journey_end: nil }
  end

  def start_journey(entry_station)
    @journey[:journey_start] = entry_station
  end

  def journey_finish(exit_station)
    @exit_station = exit_station
    @journey[:journey_end] = exit_station
    # @journey_history << @journey
    @journey_log.log(@journey)
  end

  def entry_station
    @journey[:journey_start]
  end

  def exit_station
    @journey[:journey_end]
  end

  def in_journey(state = false)
    return 'in journey' if state == true
    return 'not in journey' if state == false
  end
end
