class Station
  include InstanceCounter

  attr_accessor :name
  attr_reader :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "The name of the city should be at least 3 letter length!" if @name.length < 3
  end

  private

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end
end