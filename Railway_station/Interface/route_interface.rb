module RouteInterface
  include InstanceSearch
  include MessageSystem

  def create_route
    print MESS[:route][:basic]
    route = gets.strip
    route_obj = @routes.find { |x| x.name == route }
    raise EXCEPT[:double] unless route_obj.nil?
    st_1  = find_station(MESS[:station][:first])
    st_2  = find_station(MESS[:station][:last])
    routes << Route.new(route, st_1, st_2)
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
    puts "#{MESS[:route][:basic]} #{route.name}"
    route.stations.each { |s| print "#{s.name} " }
    print "\n"
  end

  def route_history
    route = find_route
    if route.stations_history.nil?
      print_route(route)
      return
    end
    route.stations_history.each do |arr_st|
      arr_st.each { |s| print "#{s.name} " }
      print "\n"
    end
  end
end
