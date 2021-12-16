class CargoTrain < Train
  #public cause user access these
  def initialize(name)
    @type = "cargo"
    super
  end
end