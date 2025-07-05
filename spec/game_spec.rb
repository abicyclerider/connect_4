# frozen_string_literal: true

# Tests for game class

require_relative '../lib/game'
require_relative '../lib/display'

describe Game do
  describe '.create_from_beginning' do
    context 'when a game is created from the beginning, an empty bord is displayed' do
      it 'calls display on an empty board' do
        expect(Display).to receive(:board).with(Board::EMPTY_BOARD)
        described_class.create_from_beginning
      end
    end
  end
end
