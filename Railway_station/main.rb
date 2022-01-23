# frozen_string_literal: true

require_relative 'message_system'
require_relative 'instance_counter'
require_relative 'company_name'
require_relative 'accessors'
require_relative 'validation'

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

require_relative 'instance_search'

require_relative 'station_interface'
require_relative 'route_interface'
require_relative 'train_interface'
require_relative 'wagon_interface'

require_relative 'seed'

class RailwayStation
  include WagonInterface
  include TrainInterface
  include RouteInterface
  include StationInterface
  include MessageSystem

  attr_accessor :routes

  CHOISE = { '1s' => :create_station,         '1r' => :create_route,
             '2s' => :print_stations,         '2r' => :insert_station,
             '3r' => :remove_station,
             '1t' => :create_passenger_train, '4r' => :route_history,
             '2t' => :create_cargo_train,
             '3t' => :bind_route,             '1w' => :add_wagon,
             '4t' => :move_forward,           '2w' => :remove_wagon,
             '5t' => :move_backward,          '3w' => :fill_train,
             '6t' => :print_trains,           '4w' => :print_wagons }

  def initialize
    @routes = []
    # seed
  end

  def start
    puts MENU
    loop do
      print 'Menu item: '
      str = gets.chomp

      if CHOISE[str].nil?
        print 'Would you like to quit?(y/n) '
        ans = gets.chomp
        break unless ans == 'n'

        next
      end

      send(CHOISE[str])
    end
  end
end

rs1 = RailwayStation.new
rs1.start
