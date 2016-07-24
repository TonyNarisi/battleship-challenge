require_relative 'battleship'
require_relative 'model/board'
require_relative 'view/board_display'
require_relative 'controller/game_controller'
require_relative 'controller/board_manipulation'

GameController.new.play_game

# p BoardManipulation::create_numerical_index("A2")