# frozen_string_literal: true

class Station
  extend Accessors

  include Validation,
          InstanceCounter

  attr_reader :name,
              :trains

  validate :name, :type, String

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name   = name
    @trains = []
    validate!
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
    self.trains.each(&block)
  end

  private

  def trains_by_type(type)
    self.trains.select { |train| train.type == type }.count
  end
end
