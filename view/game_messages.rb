module GameMessages

  def self.welcome_message
    puts "Welcome to Battleship!"
    puts "Here is your board:"
  end

  def self.legal_placement(eval)
    if eval
      puts "That is a legal placement."
    else
      puts "That is an illegal placement."
    end
  end
end
