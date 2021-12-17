class PassengerTrain < Train
#public cause user access these
  def initialize(number)
    @type = "passenger"
    super
  end
end