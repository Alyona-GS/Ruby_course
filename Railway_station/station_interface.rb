module StationInterface
  include InstanceSearch
  include MessageSystem

  def create_station
    print MESSAGES[:station][:general]
    station = Station.new(gets.chomp)
    success_message(:station, name: station.name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def print_stations
    puts MESSAGES[:station][:all]
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
