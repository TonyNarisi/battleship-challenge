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
    BoardDisplay::display(computer.board)

    # This loops through turns until game ends
    until @players.any? { |player| player.lost? }
      human_turn(human, computer)
    end
  end

  def human_turn(human, opponent)
    GameMessages::num_of_shots(human)
    num_of_shots = human.ships.select { |ship| !ship.sunken? }.length
    num_of_shots.times do
      shot_coordinates = UserInterface::choose_shot_coordinates
      numerical_indices = BoardManipulation::create_numerical_index(shot_coordinates)
      row = numerical_indices[1]
      column = numerical_indices[0]
      ClearScreen::reset_screen
      if opponent.board.board[row][column] != "_"
        puts "#{shot_coordinates} hit!" + "\n "
        hit_ship = opponent.ships.find { |ship| ship.coordinates.include?([row, column]) }
        hit_ship.damage_taken += 1
        human.opponents_board.board[row][column] = "X"
        GameMessages::sunk(hit_ship) if hit_ship.sunken?
      else
        puts "#{shot_coordinates} missed!" + "\n "
        human.opponents_board.board[row][column] = "/"
      end
      BoardDisplay::display(human.opponents_board)
    end
  end

end
