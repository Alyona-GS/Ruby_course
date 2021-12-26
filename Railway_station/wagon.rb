# frozen_string_literal: true

class Wagon
  include CompanyName

  attr_accessor :taken
  attr_reader :free

  def initialize(volume)
    @volume = volume
    @taken = 0
    @free = volume
  end

  def fill
    @free = @volume - taken
  end
end
