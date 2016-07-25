require_relative '../view/game_messages'
require_relative '../model/player'
require_relative '../view/board_display'
require_relative '../model/computer_player'
require_relative '../model/human_player'
require_relative '../view/clear_screen'

class GameController
  include GameMessages
  include BoardDisplay
  include ClearScreen

  def initialize
    @players = []
  end

  def play_game

    ClearScreen::reset_screen
    # This sets up the player's board
    human = HumanPlayer.new
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
      human.take_turn(human, computer)
      computer.take_turn(computer, human)
    end
    GameMessages::goodbye
  end

end
