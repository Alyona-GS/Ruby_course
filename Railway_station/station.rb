class Station
  include InstanceCounter

  attr_accessor :name
  attr_reader :trains

  @@stations = []

  def self.all
    @@stations #and if not global?
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instances
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_arrival(train)
    @trains << train
  end

  private

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end
end