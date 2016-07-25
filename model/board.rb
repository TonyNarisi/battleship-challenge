require_relative '../controller/board_manipulation'

class Board
  include BoardManipulation

  attr_accessor :board
  attr_reader :filled_in_spaces

  def initialize
    @board = Array.new(10) { Array.new(10) {"_"} }
    @filled_in_spaces = []
  end

  def place_ship(ship, starting_coordinates, direction)
    x_y_coordinates = BoardManipulation::create_numerical_index(starting_coordinates)
    row = x_y_coordinates[1]
    column = x_y_coordinates[0]
    board[row][column] = ship.code
    ship.coordinates << [row,column]
    n = 1
    if direction == "up"
      until n == ship.size
        board[row-n][column] = ship.code
        ship.coordinates << [row-n,column]
        n += 1
      end
    elsif direction == "down"
      until n == ship.size
        board[row+n][column] = ship.code
        ship.coordinates << [row+n,column]
        n += 1
      end
    elsif direction == "left"
      until n == ship.size
        board[row][column-n] = ship.code
        ship.coordinates << [row,column-n]
        n += 1
      end
    elsif direction == "right"
      until n == ship.size
        board[row][column+n] = ship.code
        ship.coordinates << [row,column+n]
        n += 1
      end
    end
    @filled_in_spaces += ship.coordinates
  end

end
