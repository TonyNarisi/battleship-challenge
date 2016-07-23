module BoardDisplay

  def self.display(game_board)
    puts "   A  B  C  D  E  F  G  H  I  J"
    n = 0
    game_board.board.each do |row|
      puts n.to_s + "  " + row.join("  ")
      n += 1
    end
  end

end
