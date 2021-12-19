class Wagon
  include CompanyName

  attr_accessor :taken, :free

  def initialize(volume)
    @volume = volume
    @taken = 0
    @free = volume
  end
end