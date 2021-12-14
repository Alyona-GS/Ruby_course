class PassengerWagon < Wagon
  #public cause class PassengerTrain uses this
  attr_reader :type

  def initialize
    @type = "passenger"
  end
end