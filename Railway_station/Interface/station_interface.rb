module StationInterface
  include InstanceSearch
  include MessageSystem

  def create_station
    print MESS[:station][:basic]
    station = gets.strip.downcase.capitalize
    raise EXCEPT[:double] unless Station.find(station).nil?
    station = Station.new(station)
    success_message(:station, name: station.name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def print_stations
    puts MESS[:station][:all]
    Station.all.each { |s| puts s.name }
  end

  def print_trains
    block = ->(train) { puts "#{train.number} #{train.type} #{train.wagons.count}" }
    find_station.trains_on_station(&block)
  rescue StandardError => e
    puts e.message
    retry
  end
end
