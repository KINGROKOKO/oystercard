require_relative 'journey'
require_relative 'oystercard'

class JourneyLog
  attr_reader :current, :journey_log, :entry_station, :exit_station

  def initialize(journey_class = Journey)
    @journey_class = journey_class.new
    # current_journey.new
    # @current_journey.new
    @journey_log = []
  end

  def log(current_journey)
    # @current_journey = current_journey
    @journey_log << current_journey
  end

  def start(entry_station)
    @entry_station = entry_station
    @journey_class.start_journey(@entry_station)
    @in_journey = true
    #^
    # @entry_station = @current_journey.entry_station
    # @current_journey.journey
  end

  # def in_progress_journey
  #   @in_progress_journey = { journey_start: nil, journey_end: nil }
  # end

  def finish(exit_station)
    @exit_station = exit_station
    @journey_class.journey_finish(@exit_station)
    @in_journey = false
  end
end



# require_relative 'journey'
# require_relative 'oystercard'
#
# class JourneyLog
#   attr_reader :current_journey, :journey_log, :entry_station
#
#   def initialize(new_journey)
#     @journey_log = []
#     @current_journey = new_journey
#   end
#
#   def start
#     @current_journey.start_journey(entry_station)
#     @entry_station = @current_journey.entry_station
#   end
#
#   def finish
#     @current_journey.journey_finish(exit_station)
#   end
#
#   def log(current_journey)
#     @current_journey = current_journey
#     @journey_log << current_journey
#   end
# end
