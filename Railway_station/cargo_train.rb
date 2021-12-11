class CargoTrain < Train
  #public cause user access these
  def initialize(name)
    super
    @type = "cargo"
  end

  def add_wagons
    self.wagons << CargoWagon.new if @speed.zero?
  end
end