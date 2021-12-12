class Train
  #public cause the user uses this
  attr_reader :type, :name

  def initialize(name)
    @name = name
    @speed = 0
    @wagons = []
  end

  def add_wagons(wagon)
    self.wagons << wagon if @speed.zero?
  end

  def remove_wagons
    @wagons.delete_at(-1) if @speed.zero? && @wagons.any?
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

  protected #cause user does not access this directly but subclasses are
  attr_reader :speed, :wagons

  private #cause user and the other parts of the program do not use it
  def station
    @route.stations[@current_station_index]
  end

  def speed_up(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end
end