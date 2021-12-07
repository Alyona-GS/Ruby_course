class Station
  attr_accessor :station_name, :train
  @@trains = []

  def initialize(station_name)
    self.station_name = station_name
  end

  def train_departure(train)
    @@trains.delete(train)
  end

  def train_arrival(train)
    self.train = train
    @@trains << train
  end

  def atm_trains
    @@trains.each { |train| puts train.train_number }
  end

  def atm_trains_by_type
    trains_by_type = [0, 0]
      @@trains.each do |train|
        case train.train_type
        when "p"
          trains_by_type[0] += 1
        when "f"
          trains_by_type[1] += 1
        end
      end
    trains_by_type
  end
end