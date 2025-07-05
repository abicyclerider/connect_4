# frozen_string_literal: true

# Class to represent a connect 4 player
class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end
