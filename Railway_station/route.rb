class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    register_instances
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless station == self.stations.last || station == self.stations.first
  end


end