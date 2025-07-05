# frozen_string_literal: true

# Class to hold the board state
class Board
  attr_accessor :board_state

  NUMBER_ROWS = 6
  NUMBER_COLUMNS = 7
  EMPTY_BOARD = Array.new(NUMBER_ROWS) { Array.new(NUMBER_COLUMNS, ' ') }.freeze

  def initialize(board_state)
    @board_state = board_state
  end

  def self.empty
    new(EMPTY_BOARD)
  end
end
