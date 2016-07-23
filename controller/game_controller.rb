require_relative '../view/game_messages'
require_relative '../model/player'
require_relative '../view/board_display'

class GameController
  include GameMessages
  include BoardDisplay

  def play_game
    player = Player.new
    GameMessages::welcome_message
    BoardDisplay::display(player.board)
    player.choose_starting_coordinates
  end

end
