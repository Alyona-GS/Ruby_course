# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'company_name'

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

require_relative 'seed'

MENU = "Press either number what do you want to do:
           1 - Create a new station
           2 - Create a new train
           3 - Create a new route
           4 - Add the station to the route
           5 - Remove the station from the route
           6 - Bind the route to the train
           7 - Add the wagons
           8 - Remove the wagons
           9 - Move the train forward
          10 - Move the train backward
          11 - Check stations list
          12 - Check trains list
          13 - Fill the train or take a seat
          14 - Check wagons list
           0 - Exit"

STATION_MESS = ['Station: ', 'Initial station: ', 'Destination: '].freeze
TRAIN_MESS = ['Number of train: ', 'Which type of train to create? (passenger/cargo): '].freeze
ROUTE_MESS = ['Route: ', 'Put name, initial station and destination: '].freeze
PASS_WAGON_MESS = ['How many seats the wagon has? ', 'Place in which wagon do you want to take? '].freeze
CAR_WAGON_MESS = ['What is the volume of the wagon? (in litres) ', 'Which wagon do you want to fill? ',
                  'How much volume do you want to fill the wagon with? (in litres) '].freeze

@routes = []

def confirm_message(num, options = {})
  case num.to_i
  when 0 then puts "The station #{options[:name]} has been created!"
  when 1 then puts "The #{options[:type]} train #{options[:number]} has been created!"
  when 2 then puts "Route #{options[:name]} has been created!"
  end
end

def find_station
  print STATION_MESS[0]
  station = gets.chomp
  Station.all.find { |x| x.name == station }
end

def find_train
  print TRAIN_MESS[0]
  Train.find(gets.chomp)
end

def find_route
  print ROUTE_MESS[0]
  route = gets.chomp
  @routes.find { |x| x.name == route }
end

def train_type
  print TRAIN_MESS[1]
  type = gets.chomp
  raise 'The type is incorrect!' unless %w[passenger cargo].include?(type)

  type
end

def passenger_wagon
  print PASS_WAGON_MESS[0]
  PassengerWagon.new(gets.chomp.to_i)
end

def cargo_wagon
  print CAR_WAGON_MESS[0]
  CargoWagon.new(gets.chomp.to_i)
end

def fill_passenger_train
  print PASS_WAGON_MESS[1]
  train.wagons[gets.chomp.to_i - 1].fill
end

def fill_cargo_train
  print CAR_WAGON_MESS[1]
  wagon = train.wagons[gets.chomp.to_i - 1]
  print CAR_WAGON_MESS[2]
  wagon.fill(gets.chomp.to_i)
end

def print_route(route)
  puts 'Your route:'
  route.stations.each { |s| puts s.name }
end

def input(message)
  print message
  gets.chomp
end

def create_station
  name = input(STATION_MESS[0])
  Station.new(name)
  confirm_message(0, name: name)
rescue StandardError => e
  puts e.message
  retry
end

def create_train
  type = train_type
  number = input(TRAIN_MESS[0])
  PassengerTrain.new(number) if type == 'passenger'
  CargoTrain.new(number) if type == 'cargo'
  confirm_message(1, number: number, type: type)
rescue StandardError => e
  puts e.message
  retry
end

def create_route
  name = input(ROUTE_MESS[1])
  @routes << Route.new(name, find_station, find_station)
  confirm_message(2, name: name)
rescue StandardError => e
  puts e.message
  retry
end

def insert_station
  route = find_route
  station = find_station
  route.add_station(station)
  print_route(route)
end

def remove_station
  route = find_route
  station = find_station
  route.delete_station(station)
  print_route(route)
end

def bind_route
  route = find_route
  train = find_train
  train.receive_route(route)
end

def add_wagon
  train = find_train
  wagon = passenger_wagon if train.type == 'passenger'
  wagon = cargo_wagon if train.type == 'cargo'
  train.add_wagons(wagon)
end

def remove_wagon
  train = find_train
  train.remove_wagons
end

def forward
  train = find_train
  train.move_forward
end

def backward
  train = find_train
  train.move_backward
end

def fill_train
  train = find_train
  fill_passenger_train if train.type == 'passenger'
  fill_cargo_train if train.type == 'cargo'
end

def print_stations
  puts 'Stations:'
  Station.all.each { |s| puts s.name }
end

def print_trains
  station = find_station
  puts 'list of the trains: '
  block = ->(train) { puts "#{train.number} #{train.type} #{train.wagons.count}" }
  station.trains_on_station(&block)
end

def print_wagons
  train = find_train
  block = ->(wagon, index) { puts "#{index + 1} #{wagon.type} #{wagon.free} #{wagon.taken}" }
  train.wagons_in_train(&block)
end

@choise = { '1' => :create_station, '2' => :create_train, '3' => :create_route, '4' => :insert_station,
            '5' => :remove_station, '6' => :bind_route, '7' => :add_wagon, '8' => :remove_wagon,
            '9' => :forward, '10' => :backward, '11' => :print_stations, '12' => :print_trains,
            '13' => :fill_train, '14' => :print_wagons }

puts MENU
seed
loop do
  number = gets.chomp
  break if @choise[number].nil?

  send(@choise[number])
end
