require 'Oystercard'

class Journey
  attr_accessor :journey_history
  attr_reader :entry_station, :exit_station, :in_journey

  def initialize
    @journey_history = []
    @journey = {:journey_start => nil, :journey_end => nil}
  end

  def journey_finish(entry_station,exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = {:journey_start => @entry_station, :journey_end => @exit_station}
    @journey_history << @journey
    @entry_station = nil
  end

  def in_journey(state=false)
    return 'in journey' if state == true
    return 'not in journey' if state == false
  end

end
