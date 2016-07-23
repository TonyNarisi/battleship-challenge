require_relative 'ship.rb'

class Destroyer < Ship

  def initialize
    super
    @size = 2
    @name = "Destroyer"
    @code = "D"
  end

end
