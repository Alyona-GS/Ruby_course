# frozen_string_literal: true

class Route
  extend Accessors
  include MessageSystem
  include InstanceCounter
  include Validation

  attr_reader :name

  attr_accessor_with_history :stations

  validate :name, :presence
  validate :name, :format, /^[A-Z]{3}-[A-Z]{3}$/
  validate :stations, :length, 2

  def self.find(name)
    # route.find { |x| x.name == name }
  end

  def initialize(name, first_station, last_station)
    @name     = name
    @stations = [first_station, last_station]
    stations.compact!
    validate!
    raise EXCEPT[:double] unless Route.find(name).nil?

    register_instances
  end

  def add_station(station)
    self.stations = stations.reject { |s| s == '' }
    stations.insert(-2, station)
  end

  def delete_station(station)
    raise EXCEPT[:no_extreme_st] if station == stations.last || station == stations.first

    self.stations = stations.reject { |s| s == station }
  end
end
