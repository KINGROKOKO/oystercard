require_relative 'oystercard'
require_relative 'journey_log'

class Journey
  attr_reader :current_journey

  def initialize
    @current_journey = { journey_start: nil, journey_end: nil }
  end

  def start_journey(entry_station)
    @current_journey[:journey_start] = entry_station.station_name
  end

  def finish_journey(exit_station)
    @exit_station = exit_station
    @current_journey[:journey_end] = exit_station.station_name
  end
end
