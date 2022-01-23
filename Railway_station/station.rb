# frozen_string_literal: true

class Station
  extend Accessors

  include MessageSystem
  include InstanceCounter
  include Validation

  attr_reader :name,
              :trains

  validate :name, :format, /^[a-zA-Z]+$/

  @@stations = []

  def self.all
    @@stations
  end

  def self.find(name)
    Station.all.find { |x| x.name == name }
  end

  def initialize(name)
    @name   = name
    @trains = []
    validate!
    raise EXCEPT[:double] unless Station.find(name).nil?

    @@stations << self
    register_instances
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_arrival(train)
    @trains << train
  end

  def trains_on_station(&block)
    trains.each(&block)
  end

  private

  def trains_by_type(type)
    trains.select { |train| train.type == type }.count
  end
end
