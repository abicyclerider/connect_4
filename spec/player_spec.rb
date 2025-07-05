# frozen_string_literal: true

# Tests for player class

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('X', 6) }
  describe '#retrieve_column' do
    context 'when user enters valid column' do
      before do
        allow(player).to receive(:gets).and_return('3')
      end

      it 'returns the column number' do
        result = player.retrieve_column
        expect(result).to eq(3)
      end
      context 'when user inputs three invalid values, then valid input' do
        before do
          allow(player).to receive(:gets).and_return('0', 'abc', '8', '3')
        end
      end
    end
  end
end
