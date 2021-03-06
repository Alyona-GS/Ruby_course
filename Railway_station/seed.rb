# frozen_string_literal: true

def seed
  st1 = Station.new('Samara')
  st2 = Station.new('Moscow')
  st3 = Station.new('Peter')

  tr1 = PassengerTrain.new('12345')
  tr2 = CargoTrain.new('23456')

  @routes << Route.new('SAM-MSK', st1, st2)
  @routes << Route.new('SPB-MSK', st3, st2)
  @routes[0].add_station(st3)
  @routes[0].delete_station(st3)

  tr1.receive_route(@routes[0])
  tr2.receive_route(@routes[0])

  tr1.add_wagons(PassengerWagon.new(70))
  tr1.add_wagons(PassengerWagon.new(80))

  tr2.add_wagons(CargoWagon.new(90))
  tr2.add_wagons(CargoWagon.new(60))

  block = ->(train) { puts "#{train.number} #{train.type} #{train.wagons.count}" }
  st1.trains_on_station(&block)

  block = ->(wagon, index) { puts "#{index + 1} #{wagon.type} #{wagon.free} #{wagon.taken}" }
  tr1.wagons_in_train(&block)
  tr2.wagons_in_train(&block)

  tr1.wagons[0].fill
  tr2.wagons[1].fill(40)

  block = ->(wagon, index) { puts "#{index + 1} #{wagon.type} #{wagon.free} #{wagon.taken}" }
  tr1.wagons_in_train(&block)
  tr2.wagons_in_train(&block)

  # create_station
  # create_station
  # print_stations
  # create_route
  # create_passenger_train
  # bind_route
  # print_trains
end
