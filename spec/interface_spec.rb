# frozen_string_literal: true

# Tests for player class

require_relative '../lib/interface'
require_relative '../lib/board'

describe Interface do
  describe '#retrieve_column' do
    context 'when user enters valid column' do
      before do
        allow(Interface).to receive(:gets).and_return('3')
      end

      it 'returns the column number' do
        result = Interface.retrieve_column(Board::NUMBER_COLUMNS)
        expect(result).to eq(3)
      end
      context 'when user inputs three invalid values, then valid input' do
        before do
          allow(Interface).to receive(:gets).and_return('99', '17', '8', '3')
        end

        it 'asks for valid input 4 times' do
          expect(Interface).to receive(:puts).exactly(4).times
          result = Interface.retrieve_column(Board::NUMBER_COLUMNS)
          expect(result).to eq(3)
        end
      end
    end
  end
end
