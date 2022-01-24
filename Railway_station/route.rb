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

  def initialize(name, first_station, last_station)
    @name     = name
    @stations = [first_station, last_station]
    validate!
    register_instances
  end

  def add_station(station)
    self.stations = stations.reject { |s| s == '' }
    stations.insert(-2, station)
  end

  def delete_station(station)
    extreme_st = (station == stations.last ||
                  station == stations.first)
    raise EXCEPT[:no_extreme_st] if extreme_st

    self.stations = stations.reject { |s| s == station }
  end
end
