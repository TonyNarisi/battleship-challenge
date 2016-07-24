require_relative 'aircraft_carrier.rb'
require_relative 'battleship.rb'
require_relative 'cruiser.rb'
require_relative 'destroyer.rb'
require_relative 'submarine.rb'
require_relative 'board.rb'
require_relative '../view/user_interface'
require_relative '../view/board_display'

class Player
  include UserInterface
  include BoardDisplay

  attr_accessor :board, :opponents_board, :coordinates_chosen
  attr_reader :ships

  def initialize
    @ships = [AircraftCarrier.new, Battleship.new, Cruiser.new, Destroyer.new, Destroyer.new, Submarine.new, Submarine.new]
    @board = Board.new
    @coordinates_chosen = []
    @opponents_board = Board.new
  end

  def choose_starting_coordinates
    @ships.each do |ship|
      legal_move = false
      until legal_move
        starting_coordinates = UserInterface::choose_starting_coordinates(ship)
        direction = UserInterface::choose_direction(ship, starting_coordinates)
        legal_move = ship.legal_placement?(@board, direction, starting_coordinates)
        GameMessages::illegal_placement if legal_move == false
      end
        board.place_ship(ship, starting_coordinates, direction)
        ClearScreen::reset_screen
        BoardDisplay::display(@board)
    end
  end

  def choose_shots
    UserInterface::choose_shot_coordinates
  end

  def lost?
    @ships.all? { |ship| ship.sunken? }
  end

end
