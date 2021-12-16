class Route
  include InstanceCounter

  attr_reader :stations, :name

  ROUTE_FORMAT = /^[A-Z]{3}-[A-Z]{3}$/

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    register_instances
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless station == self.stations.last || station == self.stations.first
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "The format of route is invalid. Should be: XXX-XXX" if @name !~ ROUTE_FORMAT
    raise "There is no such first station!" unless Station.all.include?(self.stations.first)
    raise "There is no such last station!" unless Station.all.include?(self.stations.last)
  end
end