# frozen_string_literal: true

class Route
  extend Accessors
  include Validation,
          InstanceCounter

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
    self.stations = stations.safe_insert(-2, station)
  end

  def delete_station(station)
    return if station == stations.last || station == stations.first
    self.stations = stations.reject { |s| s == station }
  end

  def validate!
    super
    raise 'At least one station does not exist' unless stations.compact.length == 2
  end
end

class Array
  def safe_insert(pos, obj_to_insert)
    arr = Marshal.load(Marshal.dump(self))
    arr.insert(pos, obj_to_insert)
  end
end

