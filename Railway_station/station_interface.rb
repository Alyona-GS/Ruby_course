module StationInterface
  include MessageSystem,
          InstanceSearch

  def create_station
    print MESSAGES[:station][:general]
    Station.new(gets.chomp)
    #success_message(:station, name: name)
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
  end
end