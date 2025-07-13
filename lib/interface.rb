# frozen_string_literal: true

# Module for retreiving and validating user input from the command line
module Interface
  def self.retrieve_column(max_columns)
    loop do
      puts "Enter column (0-#{max_columns - 1}):"
      input = gets.chomp.to_i
      return input if input.between?(0, max_columns - 1)
    end
  end

  def self.display_player(symbol)
    puts "Player #{symbol}"
  end

  def self.print_winner(symbol)
    puts "Player #{symbol} wins!"
  end

  def self.print_full
    puts 'The board is full, please play again'
  end
end
