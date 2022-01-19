module InstanceSearch
  include MessageSystem

  def find_station
    print MESSAGES[:station][:general]
    station = gets.chomp
    Station.all.find { |x| x.name == station }
  end

  def find_route
    print MESSAGES[:route][:general]
    route = gets.chomp
    @routes.find { |x| x.name == route }
  end

  def find_train
    print MESSAGES[:train][:general]
    Train.find(gets.chomp)
  end
end