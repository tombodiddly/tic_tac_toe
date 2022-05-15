# frozen_string_literal => true

# Game Class
class Game
end

# Board Class
class Board
  def initialize
    @grid = {
      1 => '1', 2 => '2', 3 => '3',
      4 => '4', 5 => '5', 6 => '6',
      7 => '7', 8 => '8', 9 => '9'
    }
  end

  def show_grid
    puts "  #{grid[1]} * #{grid[2]} * #{grid[3]} \n
  #{grid[4]} * #{grid[5]} * #{grid[6]} \n
  #{grid[7]} * #{grid[8]} * #{grid[9]}"
  end
end

# Move Class
class Move
  @@total_moves = 0

  def make_move(player, slot)
    …some stuff
    @@total_moves += 1
  end

end

# Player Class
class Player
  def initialize; end
end

# Computer Class
class Computer
  def initialize; end
end
