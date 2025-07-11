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
    describe '#take_turn' do
      context 'When a user takes a turn it asks the user for a column' do
        before do
          allow(game).to receive(:puts)
        end
        it 'calls retrieve column on Interface' do
          expect(Interface).to receive(:retrieve_column).with(Board::NUMBER_COLUMNS)
          game.take_turn
        end
      end
      context 'When a user takes a turn and enters an available position' do
        let(:empty_board) { instance_double(Board, Board::EMPTY_BOARD) }
        before do
          allow(game).to receive(:puts)
          allow(Interface).to receive(:retrieve_column).with(Board::NUMBER_COLUMNS).and_return(0)
          allow(Board).to receive(:add_piece?).with('X', 0).and_return(true)
        end
        it 'adds the piece to the board' do
          expect(empty_board).to_receive(:add_piece)
          game.take_turn
        end
      end
    end
  end
end
