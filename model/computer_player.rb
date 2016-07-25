require_relative 'player'

class ComputerPlayer < Player

  POSSIBLE_LETTERS = %w(A B C D E F G H I J)
  POSSIBLE_NUMBERS = (0..9).to_a.map { |num| num.to_s }

  def choose_starting_coordinates
    @ships.each do |ship|
      legal_move = false
      until legal_move
        starting_coordinates = choose_coordinate
        direction = ["up","down","left","right"].sample
        legal_move = ship.legal_placement?(@board, direction, starting_coordinates)
      end
        board.place_ship(ship, starting_coordinates, direction)
    end
  end

  def choose_coordinate
    POSSIBLE_LETTERS.sample + POSSIBLE_NUMBERS.sample
  end

  def choose_shot_coordinates
    repeat_choice = true
    until repeat_choice == false
      coordinate = choose_coordinate
      repeat_choice = coordinates_chosen.include?(coordinate)
    end
    coordinates_chosen << coordinate
    coordinate
  end

  def computer_turn(computer, human)
    num_of_shots = computer.ships.select { |ship| !ship.sunken? }.length
    num_of_shots.times do
      GameMessages::computer_num_of_shots(computer)
      computer.fire_shots(human)
    end
  end

  def take_turn(player, opponent)
    GameMessages::computer_num_of_shots(player)
    ships_remaining.times { player.fire_shots(player, opponent) }
  end

  def fire_shots(player, opponent)
    coordinate = choose_shot_coordinates
    numerical_indices = BoardManipulation::create_numerical_index(coordinate)
    row = numerical_indices[1]
    column = numerical_indices[0]
    ClearScreen::reset_screen
    if opponent.board.board[row][column] != "_" 
      successful_shot(player, opponent, coordinate, row, column)
    else
      missed_shot(opponent, coordinate, row, column)
    end
    BoardDisplay::display(opponent.board)
    sleep(2)
  end

  def successful_shot(player, opponent, coordinate, row, column)
    GameMessages::successful_computer_shot(coordinate)
    hit_ship = opponent.find_hit_ship(row, column)
    hit_ship.damage_taken += 1
    opponent.board.board[row][column] = "X"
    GameMessages::computer_sunk(hit_ship) if hit_ship.sunken?
  end

  def missed_shot(opponent, coordinate, row, column)
    GameMessages::missed_computer_shot(coordinate)
    opponent.board.board[row][column] = "/"
  end

end
