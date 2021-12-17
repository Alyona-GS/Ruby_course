class CargoWagon < Wagon
  attr_accessor :filled_space, :free_space
  attr_reader :type

  def initialize(volume)
    @type = "cargo"
    @volume = volume
    @filled_space = 0
    @free_space = volume
  end

  def fill (volume)
    self.filled_space += volume
    self.free_space = @volume - self.filled_space
  end
end