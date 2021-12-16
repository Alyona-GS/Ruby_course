class PassengerTrain < Train
#public cause user access these
  def initialize(name)
    @type = "passenger"
    super
  end
end