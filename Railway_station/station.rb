class Station
  #the user access this so public
  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  #public because class Train access it
  def train_departure(train)
    @trains.delete(train)
  end

  def train_arrival(train)
    @trains << train
  end

  #private cause not used elsewhere
  private
  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end
end