# frozen_string_literal: true

# Tests for game class

require_relative '../lib/game'
require_relative '../lib/display'
require_relative '../lib/interface'

describe Game do
  subject(:game) { described_class.create_from_beginning }

  before do
    allow(Display).to receive(:board)
  end
  describe '.create_from_beginning' do
    context 'when a game is created from the beginning, an empty bord is displayed' do
      it 'calls display on an empty board' do
        expect(Display).to receive(:board).with(Board::EMPTY_BOARD)
        described_class.create_from_beginning
      end
    end
  end
  describe '#take_turn' do
    context 'when a player successfully places a piece on first try' do
      before do
        allow(Interface).to receive(:retrieve_column).and_return(0)
        allow(game.board).to receive(:add_piece?).and_return(2)
        allow(game.board).to receive(:check_win?).and_return(false)
        allow(game.board).to receive(:check_full?)
        allow(game).to receive(:puts)
      end
      it 'calls Interface.retrieve_column with NUMBER_COLUMNS' do
        expect(Interface).to receive(:retrieve_column).with(Board::NUMBER_COLUMNS)
        game.take_turn
      end

      it 'calls add_piece? on board with player symbol and chosen column' do
        expect(game.board).to receive(:add_piece?).with('X', 0)
        game.take_turn
      end

      it 'checks for a winner' do
        expect(game.board).to receive(:check_win?).with('X', [2, 0])
        game.take_turn
      end

      it 'checks if the board is full' do
        expect(game.board).to receive(:check_full?)
        game.take_turn
      end

      it 'cycles to the next player' do
        expect { game.take_turn }.to(change { game.instance_variable_get(:@current_player) })
      end

      it 'displays the changed board state' do
        expect(Display).to receive(:board)
        game.take_turn
      end
    end
    context 'when a player makes an invalid move and then a valid move' do
      before do
        allow(Interface).to receive(:retrieve_column).and_return(0, 1)
        allow(game.board).to receive(:add_piece?).and_return(false, 2)
        allow(game).to receive(:puts)
      end
      it 'calls Interface.retrieve_column twice' do
        expect(Interface).to receive(:retrieve_column).with(Board::NUMBER_COLUMNS).twice
        game.take_turn
      end
      it 'calls add_piece? twice' do
        expect(game.board).to receive(:add_piece?).with('X', 0).and_return(false)
        expect(game.board).to receive(:add_piece?).with('X', 1).and_return(2)
        game.take_turn
      end
    end
  end
  describe '#play' do
    context 'When a player wins' do
      before do
        allow(game).to receive(:take_turn) do
          game.instance_variable_set(:@winner, game.instance_variable_get(:@current_player))
        end
      end
      it 'calls interface to print winning message' do
        expect(Interface).to receive(:print_winner).with('X')
        game.play
      end
    end
    context 'when the board is full' do
      before do
        allow(game).to receive(:take_turn) do
          game.instance_variable_set(:@board_full, true)
        end
      end

      it 'calls interface to print board full' do
        expect(Interface).to receive(:print_full)
        game.play
      end
    end
  end
end
