require_relative 'journey'
require_relative 'oystercard'

class JourneyLog
  attr_reader :entry_station, :exit_station

  def initialize(journey_class = Journey)
    @journey_class = journey_class.new
    @journeys = []
  end

  def journeys
    @journeys.dup
  end

  def start(entry_station)
    @entry_station = entry_station
    @journey_class.start_journey(entry_station)
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journey_class.finish_journey(exit_station)
    @journeys << @journey_class.current_journey
  end

  private

  def current_journey
    @journey_class.current_journey
  end
end
