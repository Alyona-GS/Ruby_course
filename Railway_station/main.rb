# frozen_string_literal: true

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

require_relative 'message_system'
require_relative 'instance_search'

require_relative 'station_interface'
require_relative 'route_interface'
require_relative 'train_interface'
require_relative 'wagon_interface'

require_relative 'seed'

class RailwayStation
  include StationInterface,
          RouteInterface,
          TrainInterface,
          WagonInterface

  attr_accessor :routes

  def initialize
    @routes = []
    seed
  end
end

MENU = "                     
                     MENU for Railway Station

          Stations                            Routes 
                                                   
  1s - Create a new station           1r - Create a new route
  2s - Check stations list            2r - Add a station   
                                      3r - Remove the station
           Trains                     4r - History of the route
                                                   
  1t - Create a new passenger train           Wagons
  2t - Create a new cargo train
  3t - Bind the route to the train    1w - Add the wagons
  4t - Move the train forward         2w - Remove the wagons
  5t - Move the train backward        3w - Fill the train or take a seat
  6t - Check trains list              4w - Check wagons list           

                       Exit => press any key"

@choise = { '1s' => :create_station,         '1r' => :create_route,
            '2s' => :print_stations,         '2r' => :insert_station,
                                             '3r' => :remove_station,
            '1t' => :create_passenger_train, '4r' => :route_history,
            '2t' => :create_cargo_train, 
            '3t' => :bind_route,             '1w' => :add_wagon,   
            '4t' => :move_forward,           '2w' => :remove_wagon,
            '5t' => :move_backward,          '3w' => :fill_train,
            '6t' => :print_trains,           '4w' => :print_wagons}

rs1 = RailwayStation.new

puts MENU
loop do
  str = gets.chomp
  break if @choise[str].nil?

  rs1.send(@choise[str])
end
