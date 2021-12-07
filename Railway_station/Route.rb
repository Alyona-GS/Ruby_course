class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    self.stations = [@first_station, @last_station]
  end

  def add_station(station, pos = -2)
    self.stations.insert(pos, station) unless pos == 0 || self.stations[pos] == self.stations.last
  end

  def delete_station(station)
    self.stations.delete(station) unless station == @last_station || station == @first_station
  end

  def print
    self.stations.each { |station| puts station.station_name }
  end
end