class CargoWagon
  #public cause class CargoTrain uses this
  attr_reader :type

  def initialize
    @type = "cargo"
  end
end