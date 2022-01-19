module TrainInterface
  include MessageSystem,
          InstanceSearch

  def create_passenger_train
    print MESSAGES[:train][:general]
    PassengerTrain.new(gets.chomp)
    #success_message(1, number: number, type: type)
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_cargo_train
    print MESSAGES[:train][:general]
    CargoTrain.new(gets.chomp)
    #success_message(1, number: number, type: type)
  rescue StandardError => e
    puts e.message
    retry
  end

  def bind_route
    route = find_route
    train = find_train
    train.receive_route(route)
  end

  def move_forward
    train = find_train
    train.move_forward
  end

  def move_backward
    train = find_train
    train.move_backward
  end
end