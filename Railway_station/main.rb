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

MENU = "Press either number what do you want to do:
           1 - Create a new station
           2 - Create a new train
           3 - Create a new route
           4 - Add the station to the route
           5 - Remove the station from the route
           6 - Bind the route to the train
           7 - Add the wagons
           8 - Remove the wagons
           9 - Move the trains
          10 - Check stations list
          11 - Check trains list
           0 - Exit"

@routes = []

#public, no class is in here
def find_obj(obj, obj_arr)
  obj_arr.find { |x| x.name == obj }
end

def create_station
  print "Put the name of the station: "
  name = gets.chomp
  Station.new(name)
end

def create_train
  print "Which type of train to create? (passenger/cargo): "
  type = gets.chomp
  print "Print the number of the train: "
  number = gets.chomp
  PassengerTrain.new(number) if type == "passenger"
  CargoTrain.new(number) if type == "cargo"
end

def create_route
  puts "Print name, initial station and destination (each on a new string):"
  name = gets.chomp
  first_station = find_obj(gets.chomp, Station.all)
  last_station = find_obj(gets.chomp, Station.all)

  @routes << Route.new(name, first_station, last_station)

  puts "Route #{@routes.last.name} has been created!"
end

def insert_station
  print "Which route do you want to update? "
  route = find_obj(gets.chomp, @routes)
  print "The name of the station to be added: "
  station = find_obj(gets.chomp, Station.all)

  route.add_station(station)

  puts "Your route:"
  route.stations.each { |station| puts station.name }
end

def remove_station
  print "Which route do you want to update? "
  route = find_obj(gets.chomp, @routes)
  print "The name of the station to be removed: "
  station = find_obj(gets.chomp, route.stations)

  route.delete_station(station)

  puts "Your route:"
  route.stations.each { |station| puts station.name }
end

def bind_route
  puts "Print the route and a train you do want to bind (each on a new string):"
  route = find_obj(gets.chomp, @routes)
  train = Train.find(gets.chomp)
  train.receive_route(route)
end

def add_wagon
  print "Number of train: "
  train = Train.find(gets.chomp)
  wagon = PassengerWagon.new if train.type == "passenger"
  wagon = CargoWagon.new if train.type == "cargo" 

  train.add_wagons(wagon)
end

def remove_wagon
  print "Number of train: "
  train = Train.find(gets.chomp)
  train.remove_wagons
end

def move_train
  print "Number of train you want to move: "
  train = Train.find(gets.chomp)
  print "Backward or forward? (backward/forward): "
  input = gets.chomp

  train.move_forward if input == "forward"
  train.move_backward if input == "backward"
end

def print_stations
  puts "Stations:"
  Station.all.each { |station| puts station.name }
end

def print_trains
  print "Station, please: "
  station = find_obj(gets.chomp, Station.all)
  puts "list of the trains: "
  station.trains.each { |train| puts train.name }
end

puts MENU
loop do
  number = gets.chomp.to_i
  case number
  when 1
    create_station
  when 2
    create_train
  when 3
    create_route
  when 4
    insert_station
  when 5
    remove_station
  when 6
    bind_route
  when 7
    add_wagon
  when 8
    remove_wagon
  when 9
    move_train
  when 10
    print_stations
  when 11
    print_trains
  when 0
    break
  end
end