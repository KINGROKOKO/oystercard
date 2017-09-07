class Station
  attr_reader :zone, :station_name

  def initialize(name = 'kingscross', zone = 1)
    @station_name = name.to_s
    @zone = zone.to_i
  end
end
