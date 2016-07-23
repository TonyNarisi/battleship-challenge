require_relative '../controller/board_manipulation'

describe 'create_numerical_index' do
  it 'creates an accurate numerical index' do
    expect(BoardManipulation::create_numerical_index("C4")).to eq [2,4]
  end
end
