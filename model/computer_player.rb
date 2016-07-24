require_relative 'player'

class ComputerPlayer < Player

  POSSIBLE_LETTERS = %w(A B C D E F G H I J)
  POSSIBLE_NUMBERS = (0..9).to_a.map { |num| num.to_s }

  def initialize
    super
    @coordinates_chosen = []
  end

  def choose_starting_coordinates
    @ships.each do |ship|
      legal_move = false
      until legal_move
        letters = %w(A B C D E F G H I J)
        numbers = (0..9).to_a
        starting_coordinates = letters.sample + numbers.sample.to_s
        direction = ["up","down","left","right"].sample
        legal_move = ship.legal_placement?(@board, direction, starting_coordinates)
        GameMessages::illegal_placement if legal_move == false
      end
        board.place_ship(ship, starting_coordinates, direction)
    end
  end

  def fire_shots(human)
    coordinate = choose_shot_coordinates
    numerical_indices = BoardManipulation::create_numerical_index(coordinate)
    row = numerical_indices[1]
    column = numerical_indices[0]
    ClearScreen::reset_screen
    if human.board.board[row][column] != "_"
      puts "Computer hits at #{coordinate}!"
      human.board.board[row][column] = "X"
      hit_ship = human.ships.find { |ship| ship.coordinates.include?([row, column]) }
      hit_ship.damage_taken += 1
      GameMessages::computer_sunk(hit_ship) if hit_ship.sunken?
    else
      puts "Computer misses at #{coordinate}!"
      human.board.board[row][column] = "/"
      BoardDisplay::display(human.board)
    end
    sleep(2)
  end

  def choose_shot_coordinates
    repeat_choice = true
    until repeat_choice == false
      coordinate = POSSIBLE_LETTERS.sample + POSSIBLE_NUMBERS.sample
      repeat_choice = @coordinates_chosen.include?(coordinate)
    end
    @coordinates_chosen << coordinate
    coordinate
  end

end
