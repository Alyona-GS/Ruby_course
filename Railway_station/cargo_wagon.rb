class CargoWagon < Wagon
  attr_reader :type

  def initialize(volume)
    @type = "cargo"
    super
  end

  def fill (volume)
    self.taken += volume
    self.free = @volume - self.taken
  end
end