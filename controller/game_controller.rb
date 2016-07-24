require_relative '../view/game_messages'
require_relative '../model/player'
require_relative '../view/board_display'
require_relative '../model/computer_player'

class GameController
  include GameMessages
  include BoardDisplay

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
    shot_coordinates = human.choose_shots
    shot_coordinates.each do |coordinates|
      numerical_indices = BoardManipulation::create_numerical_index(coordinates)
      row = numerical_indices[1]
      column = numerical_indices[0]
      if opponent.board.board[row][column] != "_"
        puts "#{coordinates} hit!"
        hit_ship = opponent.ships.find { |ship| ship.coordinates.include?([row,column]) }
        hit_ship.damage_taken += 1
        GameMessages::sunk(hit_ship) if hit_ship.sunken?
      end
    end
  end

end
