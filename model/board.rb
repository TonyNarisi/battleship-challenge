require_relative '../controller/board_manipulation'

class Board
  include BoardManipulation

  attr_reader :board

  def initialize
    @board = Array.new(10) { Array.new(10, "_") }
  end

  def place_ship(ship, starting_coordinates, direction)
    x_y_coordinates = BoardManipulation::create_numerical_index(starting_coordinates)
    row = x_y_coordinates[1]
    column = x_y_coordinates[0]
    @board[row][column] = ship.code
    n = 1
    if direction == "up"
      until n == ship.size
        @board[row-n][column] = ship.code
        n += 1
      end
    elsif direction == "down"
      until n == ship.size
        @board[row+n][column] = ship.code
        n += 1
      end
    elsif direction == "left"
      until n == ship.size
        @board[row][column-n] = ship.code
        n += 1
      end
    elsif direction == "right"
      until n == ship.size
        @board[row][column+n] = ship.code
        n += 1
      end
    end
  end

end
