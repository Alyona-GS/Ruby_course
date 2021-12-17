class CargoTrain < Train
  #public cause user access these
  def initialize(number)
    @type = "cargo"
    super
  end
end