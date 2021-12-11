require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

stations = []
trains = []
routes = []

#public, no class is in here
def find_obj(obj, obj_arr)
  obj_arr.find { |x| x.name == obj }
end

loop do
  puts "Press either number what do you want to do:
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
  number = gets.chomp.to_i
  case number
  when 1
    print "Put the name of the station: "
    name = gets.chomp

    stations << Station.new(name)
  when 2
    print "Which type of train to create? (passenger/cargo): "
    type = gets.chomp
    print "Print the number of the train: "
    number = gets.chomp

    trains << PassengerTrain.new(number) if type == "passenger"
    trains << CargoTrain.new(number) if type == "cargo"
  when 3
    puts "Print name, initial station and destination (each on a new string):"
    name = gets.chomp
    first_station = find_obj(gets.chomp, stations)
    last_station = find_obj(gets.chomp, stations)

    routes << Route.new(name, first_station, last_station)

    puts "Route #{routes.last.name} has been created!"
  when 4
    print "Which route do you want to update? "
    route = find_obj(gets.chomp, routes)
    print "The name of the station to be added: "
    station = find_obj(gets.chomp, stations)

    route.add_station(station)

    puts "Your route:"
    route.stations.each { |station| puts station.name }
  when 5
    print "Which route do you want to update? "
    route = find_obj(gets.chomp, routes)
    print "The name of the station to be removed: "
    station = find_obj(gets.chomp, stations)

    route.delete_station(station)

    puts "Your route:"
    route.stations.each { |station| puts station.name }
  when 6
    puts "Print the route and a train you do want to bind (each on a new string):"
    route = find_obj(gets.chomp, routes)
    train = find_obj(gets.chomp, trains)

    train.receive_route(route)
  when 7
    print "Number of train: "
    train = find_obj(gets.chomp, trains)

    train.add_wagons
  when 8
    print "Number of train: "
    train = find_obj(gets.chomp, trains)

    train.remove_wagons
  when 9
    print "Number of train you want to move: "
    train = find_obj(gets.chomp, trains)
    print "Backward or forward? (backward/forward): "
    input = gets.chomp

    train.move_forward if input == "forward"
    train.move_backward if input == "backward"
  when 10
    puts "Stations:"
    stations.each { |station| puts station.name }
  when 11
    print "Station, please: "
    station = find_obj(gets.chomp, stations)
    puts "list of the trains: "
    station.trains.each { |train| puts train.name }
  when 0
    break
  end
end