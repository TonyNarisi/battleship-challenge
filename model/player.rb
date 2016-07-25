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

  attr_accessor :board, :coordinates_chosen
  attr_reader :ships

  def initialize
    @ships = [AircraftCarrier.new, Battleship.new, Cruiser.new, Destroyer.new, Destroyer.new, Submarine.new, Submarine.new]
    @board = Board.new
    @coordinates_chosen = []
  end

  def ships_remaining
    ships.select { |ship| !ship.sunken? }.length
  end

  def lost?
    @ships.all? { |ship| ship.sunken? }
  end

  def find_hit_ship(row, column)
    ships.find { |ship| ship.coordinates.include?([row, column]) }
  end

end
