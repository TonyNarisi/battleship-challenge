require_relative 'player'

class ComputerPlayer < Player

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

end
