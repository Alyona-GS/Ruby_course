# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :type

  def initialize(volume)
    @type = :cargo
    super
  end

  def fill(volume)
    self.taken = volume
    super()
  end
end
