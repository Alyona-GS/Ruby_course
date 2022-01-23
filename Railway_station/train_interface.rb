module TrainInterface
  include InstanceSearch
  include MessageSystem

  def create_passenger_train
    print MESSAGES[:train][:general]
    train = PassengerTrain.new(gets.chomp)
    success_message(:train, number: train.number, type: 'passenger')
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_cargo_train
    print MESSAGES[:train][:general]
    train = CargoTrain.new(gets.chomp)
    success_message(:train, number: train.number, type: 'cargo')
  rescue StandardError => e
    puts e.message
    retry
  end

  def bind_route
    route = find_route
    train = find_train
    train.receive_route(route)
  rescue StandardError => e
    puts e.message
  end

  def move_forward
    train = find_train
    train.move_forward
  rescue StandardError => e
    puts e.message
  end

  def move_backward
    train = find_train
    train.move_backward
  rescue StandardError => e
    puts e.message
  end
end
