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
    @player_number = 0
    @current_player = @players[@player_number]
    @winner = nil
    @board_full = false
  end

  def self.create_from_beginning
    game = new
    Display.board(game.board.board_state)
    game
  end

  def take_turn(player = @current_player)
    Interface.display_player(player.symbol)
    row = false
    until row
      chosen_column = Interface.retrieve_column(Board::NUMBER_COLUMNS)
      row = @board.add_piece?(player.symbol, chosen_column)
    end
    @winner = @current_player if board.check_win?(
      player.symbol, [row, chosen_column]
    )
    @board_full = @board.check_full?
    Display.board(@board.board_state)
    switch_player unless @winner
  end

  def play
    until @winner || @board_full
      take_turn
      Interface.print_winner(@current_player.symbol) if @winner
      Interface.print_full unless @winner
      
    end
  end

  private

  def switch_player
    @player_number = (@player_number + 1) % @players.length
    @current_player = @players[@player_number]
  end
end
