class Train
  attr_accessor :speed, :train_wagons, :route_st
  attr_reader :train_number, :train_type

  #setters and getters for stations
  def station=(val)
    @station = val
  end
  def station
    @station.station_name
  end

  def next_station=(val)
    @next_station = val
  end
  def next_station
    @next_station.nil? ? "It is the end" : @next_station.station_name
  end

  def previous_station=(val)
    @previous_station = val
  end
  def previous_station
    @previous_station.nil? ? "It is the beginning" : @previous_station.station_name
  end

  def initialize(train_number, train_type = "p", train_wagons)
    @train_number = train_number
    @train_type = train_type
    @train_wagons = train_wagons

    self.speed = 0
  end

  def go
    self.speed = 100
  end

  def stop
    self.speed = 0
  end

  def change_wagons(action)
    if self.speed == 0
      case action
      when "add"
        self.train_wagons += 1
      when "remove"
        self.train_wagons -= 1
      end
    end
  end

  def receive_route(route)
    self.route_st = route.stations
    self.station = self.route_st[0]
    self.next_station = self.route_st[1]

    self.route_st[0].train_arrival(self)
  end

  def move(action = "forward")
    @i
    self.route_st.each_index do |j| 
      if self.route_st[j].station_name == self.station
        @i = j
        break
      end
    end

    case action
      when "forward"
        unless self.route_st[@i] == self.route_st.last
          self.previous_station = self.route_st[@i]
          self.station = self.route_st[@i + 1]
          self.next_station = self.route_st[@i + 2] unless self.station == self.route_st.last

          self.route_st[@i].train_departure(self)
          self.route_st[@i + 1].train_arrival(self)
        end
      when "backword"
        unless self.route_st[@i] == self.route_st.first
          self.next_station = self.route_st[@i]
          self.station = self.route_st[@i - 1]
          self.previous_station = self.route_st[@i - 2] unless self.station == self.route_st.first

          self.route_st[@i].train_departure(self)
          self.route_st[@i - 1].train_arrival(self)
        end
    end
  end
end