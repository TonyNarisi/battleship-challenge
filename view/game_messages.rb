module GameMessages

  def self.welcome_message
    puts "Welcome to Battleship!"
    puts "Here is your board:"
  end

  def self.illegal_placement
    puts "That is an illegal placement."
  end
end
