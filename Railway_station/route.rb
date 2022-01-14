# frozen_string_literal: true

class Route
  extend Accessors
  include Validation
  include InstanceCounter

  attr_reader :name

  attr_accessor_with_history :stations

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    validate!
    register_instances
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) unless station == stations.last || station == stations.first
  end
end
