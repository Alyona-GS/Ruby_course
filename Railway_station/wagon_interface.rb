module WagonInterface
  include MessageSystem,
          InstanceSearch

  def add_wagon
    train = find_train
    wagon = create_passenger_wagon if train.type == :passenger
    wagon = create_cargo_wagon if train.type == :cargo
    train.add_wagons(wagon)
  end

  def create_passenger_wagon
    print MESSAGES[:pass_wagon][:seats]
    PassengerWagon.new(gets.chomp.to_i)
  end

  def create_cargo_wagon
    print MESSAGES[:car_wagon][:volume]
    CargoWagon.new(gets.chomp.to_i)
  end

  def find_wagon
    print MESSAGES[:wagon][:number]
    train.wagons[gets.chomp.to_i - 1]
  end

  def fill_train
    train = find_train
    fill_passenger_train if train.type == :passenger
    fill_cargo_train if train.type == :cargo
  end

  def fill_passenger_train
    find_wagon.fill
  end

  def fill_cargo_train
    print MESSAGES[:car_wagon][:fill_volume]
    find_wagon.fill(gets.chomp.to_i)
  end

  def remove_wagon
    find_train.remove_wagons
  end

  def print_wagons
    block = ->(wagon, index) { puts "#{index + 1} #{wagon.type} #{wagon.free} #{wagon.taken}" }
    find_train.wagons_in_train(&block)
  end
end