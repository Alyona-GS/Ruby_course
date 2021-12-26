# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :type

  def initialize(volume)
    @type = 'passenger'
    super
  end

  def fill
    self.taken += 1
    super
  end
end
