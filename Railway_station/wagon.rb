# frozen_string_literal: true

class Wagon
  extend Accessors
  include CompanyName,
          MessageSystem

  strong_attr_accessor :taken, Integer
  attr_reader :free

  def initialize(volume)
    @volume = volume
    @taken = 0
    @free = volume
  end

  def fill
    diff = @free - taken
    raise EXCEPT[:limit] if diff.negative?

    @free = diff
    self.taken = @volume - @free
  end
end
