# frozen_string_literal: true

require_relative './display'
require_relative './player'

# Class for handling the logic of the game flow
class Game
  attr_accessor :board_state

  EMPTY_BOARD = Array.new(6) { Array.new(7, ' ') }.freeze

  def initialize(board_state)
    @board_state = board_state
    @players = []
  end

  def self.create_from_beginning
    game = new(EMPTY_BOARD)
    Display.board(game.board_state)
    game
  end
end
