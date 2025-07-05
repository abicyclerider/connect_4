# frozen_string_literal: true

require_relative './display'
require_relative './player'
require_relative './board'

# Class for handling the logic of the game flow
class Game
  attr_reader :board

  def initialize
    @board = Board.empty
    @players = [Player.new('X', Board::NUMBER_COLUMNS), Player.new('O', Board::NUMBER_COLUMNS)]
    @current_player = @players[0]
  end

  def self.create_from_beginning
    game = new
    Display.board(game.board.board_state)
    game
  end
end
