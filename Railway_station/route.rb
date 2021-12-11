class Route
  #all methods are public because the user needs to access them by himself (with the help of an interface)
  #stations are public too because other part of program accesses it
  attr_reader :stations, :name

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless station == self.stations.last || station == self.stations.first
  end


end