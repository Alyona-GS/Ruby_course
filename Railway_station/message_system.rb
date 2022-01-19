module MessageSystem

  MESSAGES = {

    station:    { general:     'Station:',
                  all:         'Stations:' },

    train:      { general:     'Number of train:' },

    route:      { general:     'Route:',
                  init_data:   'Put name, initial station and destination:' },

    wagon:      { number:      'Wagon number:' },

    pass_wagon: { seats:       'How many seats the wagon has?' },

    car_wagon:  { volume:      'What is the volume(L) of the wagon?',
                  fill_volume: 'How much volume(L) do you want to fill the wagon with?' }

             }.freeze

  def success_mess(name, options = {})
    case name
    when :station
      puts "The station #{options[:name]} has been created!"

    when :train 
      puts "The #{options[:type]} train #{options[:number]} has been created!"

    when :route 
      puts "Route #{options[:name]} has been created!"
    end
  end
end