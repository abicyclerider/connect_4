# frozen_string_literal: true

# Module for retreiving and validating user input from the command line
module Interface
  def self.retrieve_column(max_columns)
    loop do
      puts "Enter column (1-#{max_columns}):"
      input = gets.chomp.to_i
      return input if input.between?(1, max_columns)
    end
  end
end
