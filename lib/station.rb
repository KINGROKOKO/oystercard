class Station
  attr_reader :zone, :station_name

  def initialize(name = 'kingscross', zone = 1)
    @station_name = name
    @zone = zone
  end
end
