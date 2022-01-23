module RouteInterface
  include InstanceSearch
  include MessageSystem

  def create_route
    puts MESSAGES[:route][:init_data]
    route = gets.chomp
    double = routes.find { |x| x.name == route }
    raise EXCEPT[:double] if double

    routes << Route.new(route, find_station, find_station)
    success_message(:route, name: routes.last.name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def insert_station
    route = find_route
    station = find_station
    raise EXCEPT[:double] if route.stations.include?(station)

    route.add_station(station)
    print_route(route)
  rescue StandardError => e
    puts e.message
  end

  def remove_station
    route = find_route
    route.delete_station(find_station)
    print_route(route)
  rescue StandardError => e
    puts e.message
  end

  def print_route(route)
    puts MESSAGES[:route][:general]
    route.stations.each { |s| puts s.name }
  end

  def route_history
    route = find_route
    if route.stations_history.nil?
      route.stations.each { |s| print "#{s.name} " }
      print "\n"
      return
    end
    route.stations_history.each do |arr_st|
      arr_st.each { |s| print "#{s.name} " }
      print "\n"
    end
  end
end
