module RouteInterface
  include MessageSystem,
          InstanceSearch

  def create_route
    print MESSAGES[:route][:init_data]
    self.routes << Route.new(gets.chomp, find_station, find_station)
    #success_message(2, name: self.routes.last.name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def insert_station
    route = find_route
    route.add_station(find_station)
    print_route(route)
  end

  def remove_station
    route = find_route
    route.delete_station(find_station)
    print_route(route)
  end

  def print_route(route)
    print MESSAGES[:route][:general]
    route.stations.each { |s| puts s.name }
  end

  def route_history
    route = find_route
    route.stations_history.each do |arr_st|
      arr_st.each { |s| print "#{s.name} " }
      print "\n"
    end
  end
end