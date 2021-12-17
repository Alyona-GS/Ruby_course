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
          12 - Fill the train or take a seat
          13 - Check wagons list
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
  puts "The station #{name} has been created!"
  rescue StandardError => e
    puts e.message
    retry
end

def create_train
  print "Which type of train to create? (passenger/cargo): "
  type = gets.chomp
  raise "The type is incorrect!" unless type == "passenger" || type == "cargo"

  print "Print the number of the train: "
  number = gets.chomp

  PassengerTrain.new(number) if type == "passenger"
  CargoTrain.new(number) if type == "cargo"
  puts "The #{type} train #{number} has been created!"
  rescue StandardError => e
    puts e.message
    retry
end

def create_route
  puts "Print name, initial station and destination (each on a new string):"
  name = gets.chomp
  first_station = find_obj(gets.chomp, Station.all)
  last_station = find_obj(gets.chomp, Station.all)

  @routes << Route.new(name, first_station, last_station)
  puts "Route #{name} has been created!"
  rescue StandardError => e
    puts e.message
    retry
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

  if train.type == "passenger"
    print "How many seats the wagon has? "
    seats = gets.chomp.to_i
    wagon = PassengerWagon.new(seats)
  end

  if train.type == "cargo"
    print "What is the volume of the wagon? (in litres) "
    volume = gets.chomp.to_i
    wagon = CargoWagon.new(volume)
  end

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

def fill_train
  print "Number of train: "
  train = Train.find(gets.chomp)

  if train.type == "passenger"
    print "Place in which wagon do you want to take? "
    wagon = train.wagons[gets.chomp.to_i - 1]
    wagon.take_place
  end

  if train.type == "cargo"
    print "Which wagon do you want to fill? "
    wagon = train.wagons[gets.chomp.to_i - 1]
    print "How much volume do you want to fill the wagon with? (in litres) "
    volume = gets.chomp.to_i
    wagon.fill (volume)
  end
end

def print_stations
  puts "Stations:"
  Station.all.each { |station| puts station.name }
end

def print_trains
  print "Station, please: "
  station = find_obj(gets.chomp, Station.all)
  puts "list of the trains: "
  block = lambda { |train| puts "#{train.number} #{train.type} #{train.wagons.count}" }
  station.trains_on_station(&block)
end

def print_wagons
  print "Number of train: "
  train = Train.find(gets.chomp)
  if train.type == "passenger"
    block = lambda { |wagon, index| puts "#{index + 1} #{wagon.type} #{wagon.free_seats} #{wagon.taken_seats}" }
  end
  if train.type == "cargo"
    block = lambda { |wagon, index| puts "#{index + 1} #{wagon.type} #{wagon.free_space} #{wagon.filled_space}" }
  end
  
  train.wagons_in_train(&block)
end

def seed
  Station.new("Samara")
  Station.new("Moscow")
  Station.new("Peter")
  PassengerTrain.new("12345")
  CargoTrain.new("23456")
  PassengerTrain.new("34567")
  CargoTrain.new("45678")
end
  
puts MENU
seed
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
  when 12
    fill_train
  when 13
    print_wagons
  when 0
    break
  end
end