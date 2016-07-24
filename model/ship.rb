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

  def legal_placement?(player_board, direction, starting_coordinates)
    x_y_coordinates = BoardManipulation::create_numerical_index(starting_coordinates)
    row = x_y_coordinates[1]
    column = x_y_coordinates[0]
    coordinates_to_check = []
    if direction == "up"
      row - (@size - 1) >= 0
    elsif direction == "down"
      if row + (@size - 1) <= 9
        n = row
        until n == row + @size
          coordinates_to_check << [n,column]
          n += 1
        end
        coordinates_to_check.none? { |coordinate| player_board.filled_in_spaces.include?(coordinate)}
      end
    elsif direction == "right"
      column + (@size - 1) <= 9
        # coordinates_to_check << board[column][]
    elsif direction == "left"
      column - (@size - 1) >= 0
    end
  end

end
