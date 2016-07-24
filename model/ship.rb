require_relative '../controller/board_manipulation'

class Ship
  include BoardManipulation

  attr_reader :name, :code, :size
  attr_accessor :coordinates

  def initialize
    @damage_taken = 0
    @size = 0
    @name = ""
    @coordinates = []
  end

  def sunken?
    @damage_taken == @size
  end

  def legal_placement_size?(direction, starting_coordinates)
    x_y_coordinates = BoardManipulation::create_numerical_index(starting_coordinates)
    row = x_y_coordinates[1]
    column = x_y_coordinates[0]
    if direction == "up"
      row - (@size - 1) >= 0
    elsif direction == "down"
      row + (@size - 1) <= 9
    elsif direction == "right"
      column + (@size - 1) <= 9
    elsif direction == "left"
      column - (@size - 1) >= 0
    end
  end

end
