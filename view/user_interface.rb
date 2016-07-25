module UserInterface

  def self.choose_shot_coordinates
    puts "Please choose a coordinate to fire on."
    gets.chomp
  end

  def self.choose_starting_coordinates(ship)
    puts "Please choose a coordinate to begin placing #{ship.name}."
    gets.chomp
  end

  def self.choose_direction(ship, starting_coordinates)
    puts "Please choose a direction (up, down, left, or right) from #{starting_coordinates} in which to place #{ship.name}"
    gets.chomp
  end
end
