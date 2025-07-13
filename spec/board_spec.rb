# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#find_empty_row' do
    context 'When the board is empty' do
      let(:bottom_row) { 0 }
      subject(:empty_board) { described_class.empty }
      it 'returns bottom row of the board' do
        result = empty_board.find_empty_row(0)
        expect(result).to eq(bottom_row)
      end
    end
    context 'When the board is diagonal' do
      subject(:diagonal_board) do
        diagonal = [
          ['X', 'X', 'X', 'X', 'X', 'X', ' '],
          ['X', 'X', 'X', 'X', 'X', ' ', ' '],
          ['X', 'X', 'X', 'X', ' ', ' ', ' '],
          ['X', 'X', 'X', ' ', ' ', ' ', ' '],
          ['X', 'X', ' ', ' ', ' ', ' ', ' '],
          ['X', ' ', ' ', ' ', ' ', ' ', ' ']
        ]
        described_class.new(diagonal)
      end
      it 'returns nil for the first column' do
        result = diagonal_board.find_empty_row(0)
        expect(result).to be_nil
      end
      it 'returns the top row for the second column' do
        result = diagonal_board.find_empty_row(1)
        expect(result).to eq(Board::NUMBER_ROWS - 1)
      end
    end
  end
  describe '#add_piece' do
    context 'When the board is diagonal' do
      subject(:diagonal_board) do
        diagonal = [
          ['X', 'X', 'X', 'X', 'X', 'X', ' '],
          ['X', 'X', 'X', 'X', 'X', ' ', ' '],
          ['X', 'X', 'X', 'X', ' ', ' ', ' '],
          ['X', 'X', 'X', ' ', ' ', ' ', ' '],
          ['X', 'X', ' ', ' ', ' ', ' ', ' '],
          ['X', ' ', ' ', ' ', ' ', ' ', ' ']
        ]
        described_class.new(diagonal)
      end
      let(:piece_added) do
        [
          ['X', 'X', 'X', 'X', 'X', 'X', ' '],
          ['X', 'X', 'X', 'X', 'X', ' ', ' '],
          ['X', 'X', 'X', 'X', ' ', ' ', ' '],
          ['X', 'X', 'X', ' ', ' ', ' ', ' '],
          ['X', 'X', ' ', ' ', ' ', ' ', ' '],
          ['X', 'X', ' ', ' ', ' ', ' ', ' ']
        ]
      end
      it 'adds the piece to the second column' do
        result = diagonal_board.add_piece?('X', 1)
        expect(diagonal_board.board_state).to eq(piece_added)
        expect(result).to eq(5)
      end
    end
  end
  describe '#check_win?' do
    context 'When four pieces are connected in a row' do
      subject(:connected) do
        connected = [
          [' ', ' ', 'X', 'X', 'X', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', 'X'],
          ['X', 'X', 'X', 'X', 'X', 'X', ' '],
          [' ', 'X', ' ', 'X', ' ', 'X', ' '],
          [' ', ' ', 'X', ' ', ' ', 'X', ' '],
          [' ', 'X', ' ', 'X', ' ', 'X', ' ']
        ]
        described_class.new(connected)
      end
      it 'returns true when the end piece is checked' do
        result = connected.check_win?('X', [2, 0])
        expect(result).to be true
      end
      it 'returns true when the piece is in the middle' do
        result = connected.check_win?('X', [2, 2])
        expect(result).to be true
      end
      it 'returns true for negative diagonal' do
        result = connected.check_win?('X', [3, 3])
        expect(result).to be true
      end
      it 'returns true for positive diagonal' do
        result = connected.check_win?('X', [5, 3])
        expect(result).to be true
      end

      it 'returns true for a column' do
        result = connected.check_win?('X', [2, 5])
        expect(result).to be true
      end

      it 'returns false for three pieces in a row' do
        result = connected.check_win?('X', [0, 2])
        expect(result).to be false
      end
      it 'returns false for non-linear connection' do
        result = connected.check_win?('X', [1, 6])
        expect(result).to be false
      end
    end
    describe '#check_full?' do
      context 'When the board is not full' do
        subject(:empty_board) { described_class.new(Board::EMPTY_BOARD) }
        it 'returns false' do
          result = empty_board.check_full?
          expect(result).to be false
        end
      end
      context 'when the board is full' do
        subject(:full_board) do
          full_board = Array.new(Board::NUMBER_ROWS) { Array.new(Board::NUMBER_COLUMNS) { 'X' } }
          described_class.new(full_board)
        end
        it 'returns true' do
          result = full_board.check_full?
          expect(result).to be true
        end
      end
    end
  end
end
