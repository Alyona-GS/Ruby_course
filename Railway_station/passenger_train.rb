class PassengerTrain < Train
#public cause user access these
  def initialize(name)
    super
    @type = "passenger"
  end
end