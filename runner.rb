require_relative 'model/board'
require_relative 'model/ship'
require_relative 'model/aircraft_carrier'
require_relative 'model/battleship'
require_relative 'model/computer_player'
require_relative 'model/cruiser'
require_relative 'model/destroyer'
require_relative 'model/human_player'
require_relative 'model/submarine'
require_relative 'view/board_display'
require_relative 'view/clear_screen'
require_relative 'view/game_messages'
require_relative 'view/user_interface'
require_relative 'controller/game_controller'
require_relative 'controller/board_manipulation'

GameController.new.play_game