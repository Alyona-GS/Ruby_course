# frozen_string_literal: true

class Wagon
  extend Accessors
  include CompanyName

  strong_attr_accessor :taken, Integer
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
