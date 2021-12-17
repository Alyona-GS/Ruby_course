class PassengerWagon < Wagon
  attr_accessor :taken_seats, :free_seats
  attr_reader :type

  def initialize(seats)
    @type = "passenger"
    @seats = seats
    @taken_seats = 0
    @free_seats= seats
  end

  def take_place
    self.taken_seats += 1
    self.free_seats = @seats - self.taken_seats
  end
end