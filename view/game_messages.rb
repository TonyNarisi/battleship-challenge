module GameMessages

  def self.welcome_message
    puts "Welcome to Battleship!"
    puts "Here is your board:"
  end

  def self.illegal_placement
    puts "That is an illegal placement."
  end

  def self.computer_chosen_coordinates
    puts "The computer has chosen their ship placement. Begin game!"
  end

  def self.num_of_shots(player)
    num_of_shots = player.ships.select { |ship| !ship.sunken? }.length
    puts "You have #{num_of_shots} shots to fire this round."
  end

  def self.computer_num_of_shots(computer)
    num_of_shots = computer.ships.select { |ship| !ship.sunken? }.length
    puts "The computer has #{num_of_shots} shots to fire this round."
  end

  def self.sunk(ship)
    puts "You sunk your opponent's #{ship.name}!" + "\n "
  end

  def self.computer_sunk(ship)
    puts "The computer sunk your #{ship.name}!"
  end

  def goodbye
    puts "Goodbye, thank you for playing!"
  end
end
