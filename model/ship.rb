require_relative '../controller/board_manipulation'

class Ship
  include BoardManipulation

  attr_reader :name, :code, :size
  attr_accessor :coordinates, :damage_taken

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
    coordinates = BoardManipulation::create_numerical_index(starting_coordinates)
    row = coordinates[1]
    column = coordinates[0]
    coordinates_to_check = []
    if direction == "up"
      check_up(row, column, player_board, coordinates_to_check)
    elsif direction == "down"
      check_down(row, column, player_board, coordinates_to_check)
    elsif direction == "right"
      check_right(row, column, player_board, coordinates_to_check)
    elsif direction == "left"
      check_left(row, column, player_board, coordinates_to_check)
    end
  end

  def check_up(row, column, player_board, coordinates_to_check)
    if row - (size - 1) >= 0
      n = row
      until n == row - size
        coordinates_to_check << [n,column]
        n -= 1
      end
      confirm_availability(coordinates_to_check, player_board)
    end
  end  

  def check_down(row, column, player_board, coordinates_to_check)
    if row + (size - 1) <= 9
      n = row
      until n == row + size
        coordinates_to_check << [n,column]
        n += 1
      end
      confirm_availability(coordinates_to_check, player_board)
    end
  end

  def check_right(row, column, player_board, coordinates_to_check)
    if column + (size - 1) <= 9
      n = column
      until n == column + size
        coordinates_to_check << [row, n]
        n += 1
      end
      confirm_availability(coordinates_to_check, player_board)
    end
  end

  def check_left(row, column, player_board, coordinates_to_check)
    if column - (size - 1) >= 0
      n = column
      until n == column - size
        coordinates_to_check << [row, n]
        n -= 1
      end
      confirm_availability(coordinates_to_check, player_board)
    end
  end

  def confirm_availability(coordinates_to_check, player_board)
    coordinates_to_check.none? { |coordinate| player_board.filled_in_spaces.include?(coordinate) }
  end

end
