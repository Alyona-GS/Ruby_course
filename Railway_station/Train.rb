class Train
  attr_reader :type, :speed, :wagons_count

  def initialize(number, type, wagons_count)
    @number = number
    @type = type if type == "passenger" || type == "cargo"
    @wagons_count = wagons_count

    @speed = 0
  end

  #getters for stations
  def station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def speed_up(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagons
    @wagons_count += 1 if @speed == 0
  end

  def remove_wagons
    @wagons_count -= 1 if @speed == 0 && @wagons_count > 0
  end

  def receive_route(route)
    @route = route
    @current_station_index = 0
    @route.stations[@current_station_index].train_arrival(self)
  end

  def move_forward
    unless @route.stations[@current_station_index] == @route.stations.last
      @route.stations[@current_station_index].train_departure(self)
      @current_station_index += 1 
      @route.stations[@current_station_index].train_arrival(self)
    end
  end

  def move_backward
    unless @current_station_index == 0
      @route.stations[@current_station_index].train_departure(self)
      @current_station_index -= 1 
      @route.stations[@current_station_index].train_arrival(self)
    end
  end
end