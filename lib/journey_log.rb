require_relative 'journey'
require_relative 'oystercard'

class JourneyLog
  attr_reader :current_journey, :journey_log

  def initialize
    @journey_log = []
  end

  def log(current_journey)
    # @current_journey = current_journey
    @journey_log << current_journey
  end
end
