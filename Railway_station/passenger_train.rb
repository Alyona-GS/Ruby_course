class PassengerTrain < Train
#public cause user access these
  def initialize(name)
    super
    @type = "passenger"
  end

  def add_wagons
    self.wagons << PassengerWagon.new if @speed.zero?
  end
end