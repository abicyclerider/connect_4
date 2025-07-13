# frozen_string_literal: true

# Class to hold the board state
class Board
  attr_accessor :board_state

  NUMBER_ROWS = 6
  NUMBER_COLUMNS = 7
  EMPTY_POSITION = ' '
  EMPTY_BOARD = Array.new(NUMBER_ROWS) { Array.new(NUMBER_COLUMNS, EMPTY_POSITION) }.freeze

  def initialize(board_state)
    @board_state = board_state
  end

  def self.empty
    new(EMPTY_BOARD)
  end

  def add_piece?(symbol, column_index)
    row = find_empty_row(column_index)
    return false unless row

    @board_state[row][column_index] = symbol
    row
  end

  def check_win?(symbol, position)
    directions = [
      [0, 1], # horizontal
      [1, 0],   # vertical
      [1, 1],   # diagonal (top-left to bottom-right)
      [1, -1]   # diagonal (top-right to bottom-left)
    ]
    directions.any? { |direction| check_direction_win?(symbol, position, direction) }
  end

  def find_empty_row(column_index)
    column = @board_state.map { |row| row[column_index] }
    column.find_index { |element| element == EMPTY_POSITION }
  end

  def check_full?
    @board_state.last.none? { |cell| cell == EMPTY_POSITION }
  end

  private

  def position_add(position, delta)
    position.zip(delta).map { |p, d| p + d }
  end

  def check_direction_win?(symbol, position, direction)
    right_connections = count_direction(position, symbol, direction)
    left_connections = count_direction(position, symbol, direction.map(&:-@))
    right_connections + left_connections + 1 >= 4
  end

  def count_direction(position, symbol, direction)
    count = 0
    current_position = position_add(position, direction)

    while valid_position?(current_position) && @board_state[current_position[0]][current_position[1]] == symbol
      count += 1
      current_position = position_add(current_position, direction)
    end

    count
  end

  def valid_position?(position)
    position[0].between?(0, NUMBER_ROWS - 1) && position[1].between?(0, NUMBER_COLUMNS - 1)
  end
end
