class Station
  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_arrival(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end
end