require_relative 'ship.rb'

class Submarine < Ship

  def initialize
    super
    @size = 1
    @name = "Submarine"
    @code = "S"
  end

end
