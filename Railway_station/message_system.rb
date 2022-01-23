module MessageSystem
  MENU = "
                     MENU for Railway Station

          Stations                            Routes

  1s - Create a new station           1r - Create a new route
  2s - Check stations list            2r - Add a station
                                      3r - Remove the station
           Trains                     4r - History of the route

  1t - Create a new passenger train           Wagons
  2t - Create a new cargo train
  3t - Bind the route to the train    1w - Add the wagons
  4t - Move the train forward         2w - Remove the wagons
  5t - Move the train backward        3w - Fill the train or take a seat
  6t - Check trains list              4w - Check wagons list

                       Exit => press any key"

  MESSAGES = {

    station: { general: 'Station:',
               all: 'Stations:' },

    train: { general: 'Number of train:' },

    route: { general: 'Route:',
             init_data: 'Put name, initial station and destination' },

    wagon: { number: 'Wagon number:' },

    pass_wagon: { seats:       'How many seats the wagon has?' },

    car_wagon: { volume: 'What is the volume(L) of the wagon?',
                 fill_volume: 'How much volume(L) do you want to fill the wagon with?' }

  }.freeze

  ERRORS = { not_exist: 'The object does not exist',
             no_match_class: 'The type of data is invalid',
             incorr_format: 'The format of data is invalid',
             length: 'At least one station does not exist' }.freeze

  EXCEPT = { pos_numb: 'Number of wagon must be real',
             exist_numb: 'There is no wagon with this number',

             no_station: 'There is no such a station',
             no_route: 'There is no such a route',
             no_train: 'There is no such train',
             no_wagons: 'There is no wagons yet',

             double: "It's a double",

             the_end: "That's the end!",
             the_start: "That's the beginning",
             no_extreme_st: "You can't change tha first and last station of the route" }.freeze

  def success_message(name, options = {})
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
