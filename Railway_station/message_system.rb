module MessageSystem
  MENU = "
                     MENU for Railway Station

          Stations                            Routes

  1s - Create a new station           1r - Create a new route
         (only letters)                     (format: XXX-XXX)

  2s - Check stations list            2r - Add a station
                                      3r - Remove the station
           Trains                     4r - History of the route

  1t - Create a new passenger train           Wagons
  2t - Create a new cargo train         
        (format: xxx-xx or xxxxx)     1w - Add the wagons
                                      2w - Remove the wagons
  3t - Assign the route to the train  3w - Fill the train/
  4t - Move the train forward                take a seat
  5t - Move the train backward        
  6t - Check trains list              4w - Check wagons list

                       Exit => press any key"

  MESS = {

    station:    
      { basic:  'Station: ',
        all:    'Available stations:',
        first:  'First station: ',
        last:   "Last station: " },

    train:
      { basic:  'Number of train: ' },

    route:
      { basic:  'Name of the route: ' },

    wagon:
      { number: 'Wagon number: ' },

    pass_wagon:
      { seats:  'Number of seats in the wagon: ' },

    car_wagon:
      { volume: 'Overall volume(L) of the wagon: ',
        fill:   'Volume(L) to fill the wagon with: ' }

  }.freeze

  ERRORS = {
    presence:         "The object does not exist",
    no_match_class: 'The type of data is invalid',
    incorr_format:  'The format of data is invalid',
    length:         'At least one station does not exist',

    no_station: "The station doesn't exist yet",
    no_route:   "The route doesn't exist yet",
    no_train:   "The train doesn't exist yet"
  }.freeze

  ERR_EXC = {
    presence: "ERRORS[:presence] if obj.nil? || obj.empty?",
    format: 'ERRORS[:incorr_format] if obj !~ args[0]',
    type:   'ERRORS[:no_match_class] unless obj.instance_of?(args[0])',
    length: 'ERRORS[:length] unless obj.length == args[0]',

    no_station: "ERRORS[:no_station] if obj.nil?",
    no_route:   "ERRORS[:no_route] if obj.nil?",
    no_train:   "ERRORS[:no_train] if obj.nil?"
  }.freeze

  EXCEPT = {
    pos_numb:   'Number of wagon must be real',
    exist_numb: 'There is no wagon with this number',

    no_station: "The station doesn't exist yet",
    no_route:   "The route doesn't exist yet",
    no_train:   "The train doesn't exist yet",
    no_wagons:  'There is no wagons yet',

    double: "It's a double",

    the_end:       "That's the end!",
    the_start:     "That's the beginning",
    no_extreme_st: "You can't change the first and last station of the route",

    not_binded: "You should assign the route to train before moving",
    limit:      "You can't fill more its limit"
            }.freeze

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
