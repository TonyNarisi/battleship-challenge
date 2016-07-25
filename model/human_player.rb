require_relative 'player'

class HumanPlayer < Player

  attr_accessor :opponents_board

  def initialize
    super
    @opponents_board = Board.new
  end

  def choose_starting_coordinates
    @ships.each do |ship|
      legal_move = false
      until legal_move
        starting_coordinates = UserInterface::choose_starting_coordinates(ship)
        direction = UserInterface::choose_direction(ship, starting_coordinates)
        legal_move = ship.legal_placement?(board, direction, starting_coordinates)
        GameMessages::illegal_placement if legal_move == false
      end
        board.place_ship(ship, starting_coordinates, direction)
        ClearScreen::reset_screen
        BoardDisplay::display(board)
    end
  end

  def take_turn(player, opponent)
    GameMessages::num_of_shots(player)
    ships_remaining.times do
      coordinate = choose_shot_coordinate
      numerical_indices = BoardManipulation::create_numerical_index(coordinate)
      row = numerical_indices[1]
      column = numerical_indices[0]
      ClearScreen::reset_screen
      if opponent.board.board[row][column] != "_"
        successful_shot(player, opponent, coordinate, row, column)
      else
        missed_shot(player, coordinate, row, column)
      end
      BoardDisplay::display(player.opponents_board)
    end
  end

  def successful_shot(player, opponent, coordinate, row, column)
    GameMessages::successful_shot(coordinate)
    hit_ship = opponent.find_hit_ship(row, column)
    hit_ship.damage_taken += 1
    player.opponents_board.board[row][column] = "X"
    GameMessages::sunk(hit_ship) if hit_ship.sunken?
  end

  def missed_shot(player, coordinate, row, column)
    GameMessages::missed_shot(coordinate)
    player.opponents_board.board[row][column] = "/"
  end

  def ships_remaining
    ships.select { |ship| !ship.sunken? }.length
  end

  def choose_shot_coordinate
    repeat_choice = true
    until repeat_choice == false
      coordinate = UserInterface::choose_shot_coordinates
      if @coordinates_chosen.include?(coordinate)
        repeat_choice = true
        GameMessages::repeat_coordinate
      else
        repeat_choice = false
      end
    end
    @coordinates_chosen << coordinate
    coordinate
  end

end
