# frozen_string_literal: true

require_relative 'all_required'

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
      puts "--------------------------"
      print "Menu item: "

      str = gets.strip

      if CHOISE[str].nil?
        print 'Do you want to quit? ("y" => yes, other key => no) '
        ans = gets.strip.downcase
        break if ans == 'y'

        next
      end

      send(CHOISE[str])
    end
  end
end

rs1 = RailwayStation.new
rs1.start
