require_relative 'ship.rb'

class Cruiser < Ship

  def initialize
    super
    @size = 3
    @name = "Cruiser"
    @code = "C"
  end

end
