module WagonInterface
  include InstanceSearch
  include MessageSystem

  def add_wagon
    train = find_train
    wagon = create_passenger_wagon if train.type == :passenger
    wagon = create_cargo_wagon if train.type == :cargo
    train.add_wagons(wagon)
  rescue StandardError => e
    puts e.message
  end

  def create_passenger_wagon
    print MESS[:pass_wagon][:seats]
    PassengerWagon.new(gets.strip.to_i)
  end

  def create_cargo_wagon
    print MESS[:car_wagon][:volume]
    CargoWagon.new(gets.strip.to_i)
  end

  def find_wagon(train)
    print MESS[:wagon][:number]
    wagon_number = gets.strip.to_i
    raise EXCEPT[:pos_numb] unless wagon_number.positive?
    raise EXCEPT[:exist_numb] if train.wagons[wagon_number - 1].nil?

    train.wagons[wagon_number - 1]
  end

  def fill_train
    train = find_train
    fill_passenger_train(train) if train.type == :passenger
    fill_cargo_train(train) if train.type == :cargo
  rescue StandardError => e
    puts e.message
  end

  def fill_passenger_train(train)
    find_wagon(train).fill
  rescue StandardError => e
    puts e.message
  end

  def fill_cargo_train(train)
    wagon = find_wagon(train)
    print MESS[:car_wagon][:fill]
    wagon.fill(gets.strip.to_i)
  rescue StandardError => e
    puts e.message
  end

  def remove_wagon
    find_train.remove_wagons
  rescue StandardError => e
    puts e.message
  end

  def print_wagons
    train = find_train
    block = ->(wagon, index) { puts "#{index + 1} #{wagon.type} #{wagon.free} #{wagon.taken}" }
    train.wagons_in_train(&block)
  rescue StandardError => e
    puts e.message
  end
end
