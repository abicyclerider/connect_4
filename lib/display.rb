# frozen_string_literal: true

# Module for displaying board state on the command line
module Display
  def self.board(grid)
    puts format_grid(grid)
  end

  def self.format_grid(grid)
    grid.map(&:join).join("\n")
  end
end
