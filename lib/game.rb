# frozen_string_literal: true

require_relative './display'
require_relative './player'
require_relative './board'
require_relative './interface'

# Class for handling the logic of the game flow
class Game
  attr_reader :board

  def initialize
    @board = Board.empty
    @players = [Player.new('X'), Player.new('O')]
    @current_player = @players[0]
  end

  def self.create_from_beginning
    game = new
    Display.board(game.board.board_state)
    game
  end

  def take_turn(player = @current_player)
    puts "Player #{player.symbol}"
    success = false
    until success
      chosen_column = Interface.retrieve_column(Board::NUMBER_COLUMNS)
      success = @board.add_piece?(player.symbol, chosen_column)
    end
  end
end
