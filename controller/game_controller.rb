require_relative '../view/game_messages'
require_relative '../model/player'
require_relative '../view/board_display'
require_relative '../model/computer_player'
require_relative '../view/clear_screen'

class GameController
  include GameMessages
  include BoardDisplay
  include ClearScreen

  def initialize
    @players = []
  end

  def play_game
    # This sets up the player's board
    human = Player.new
    @players << human
    GameMessages::welcome_message
    BoardDisplay::display(human.board)
    human.choose_starting_coordinates

    # This sets up computer board randomly and legally
    computer = ComputerPlayer.new
    @players << computer
    computer.choose_starting_coordinates
    GameMessages::computer_chosen_coordinates

    # This loops through turns until game ends
    until @players.any? { |player| player.lost? }
      human_turn(human, computer)
      computer_turn(computer, human)
    end

    GameMessages::goodbye
  end

  def human_turn(human, opponent)
    GameMessages::num_of_shots(human)
    num_of_shots = human.ships.select { |ship| !ship.sunken? }.length
    num_of_shots.times do
      repeat_choice = true
      until repeat_choice == false
        coordinate = UserInterface::choose_shot_coordinates
        repeat_choice = human.coordinates_chosen.include?(coordinate)
        puts "You have already chosen that coordinate, please choose again."
      end
      human.coordinates_chosen << coordinate
      numerical_indices = BoardManipulation::create_numerical_index(coordinate)
      row = numerical_indices[1]
      column = numerical_indices[0]
      ClearScreen::reset_screen
      if opponent.board.board[row][column] != "_" 
        puts "#{coordinate} hit!" + "\n "
        hit_ship = opponent.ships.find { |ship| ship.coordinates.include?([row, column]) }
        hit_ship.damage_taken += 1
        human.opponents_board.board[row][column] = "X"
        GameMessages::sunk(hit_ship) if hit_ship.sunken?
      else
        puts "#{coordinate} missed!" + "\n "
        human.opponents_board.board[row][column] = "/"
      end
      BoardDisplay::display(human.opponents_board)
    end
  end

  def computer_turn(computer, human)
    num_of_shots = computer.ships.select { |ship| !ship.sunken? }.length
    num_of_shots.times do
      GameMessages::computer_num_of_shots(computer)
      computer.fire_shots(human)
    end
  end

end
