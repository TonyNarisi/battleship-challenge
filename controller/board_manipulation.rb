module BoardManipulation

  def self.convert_column_to_index(letter)
    columns = %w(A B C D E F G H I J)
    columns.index(letter)
  end

  def self.create_numerical_index(coordinates)
    numerical_indices = coordinates.split("")
    numerical_indices[0] = convert_column_to_index(numerical_indices[0])
    numerical_indices = numerical_indices.map { |elm| elm.to_i }
  end

end
