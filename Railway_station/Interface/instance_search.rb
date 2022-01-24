module InstanceSearch
  include MessageSystem

  def call(exception, obj)
    err = eval(exception)
    raise err unless err.nil?
  end

  def find_station(message = false)
    print message ? message : MESS[:station][:basic]
    station = Station.find(gets.strip.downcase.capitalize)
    call(ERR_EXC[:no_station], station)

    station
  end

  def find_route(message = false)
    print message ? message : MESS[:route][:basic]
    user_route = gets.strip
    route      = @routes.find { |x| x.name == user_route }
    call(ERR_EXC[:no_route], route)

    route
  end

  def find_train(message = false)
    print message ? message : MESS[:train][:basic]
    train = Train.find(gets.strip)
    call(ERR_EXC[:no_train], train)

    train
  end
end
