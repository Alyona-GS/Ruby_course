module InstanceSearch
  include MessageSystem

  def find_station
    print MESSAGES[:station][:general]
    station_obj = Station.find(gets.chomp)
    raise EXCEPT[:no_station] if station_obj.nil?

    station_obj
  end

  def find_route
    print MESSAGES[:route][:general]
    route = gets.chomp
    route_obj = @routes.find { |x| x.name == route }
    raise EXCEPT[:no_route] if route_obj.nil?

    route_obj
  end

  def find_train
    print MESSAGES[:train][:general]
    train_obj = Train.find(gets.chomp)
    raise EXCEPT[:no_train] if train_obj.nil?

    train_obj
  end
end
