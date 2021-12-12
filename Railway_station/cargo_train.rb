class CargoTrain < Train
  #public cause user access these
  def initialize(name)
    super
    @type = "cargo"
  end
end