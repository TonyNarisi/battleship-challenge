require_relative 'ship.rb'

class Battleship < Ship

  def initialize
    super
    @size = 4
    @name = "Battleship"
    @code = "B"
  end

end
