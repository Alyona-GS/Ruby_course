# frozen_string_literal: true

class Train
  extend Accessors
  include Validation
  include InstanceCounter

  attr_reader :type, :number, :trains, :wagons

  @@trains = []

  def self.find(number)
    @@trains.find { |x| x.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains << self
    register_instances
  end

  def add_wagons(wagon)
    wagons << wagon if @speed.zero?
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
    return if @route.stations[@current_station_index] == @route.stations.last

    @route.stations[@current_station_index].train_departure(self)
    @current_station_index += 1
    @route.stations[@current_station_index].train_arrival(self)
  end

  def move_backward
    return if @current_station_index.zero?

    @route.stations[@current_station_index].train_departure(self)
    @current_station_index -= 1
    @route.stations[@current_station_index].train_arrival(self)
  end

  def wagons_in_train(&block)
    @wagons.each_with_index(&block)
  end

  protected

  include CompanyName
  attr_reader :speed

  private

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
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end
end
