# frozen_string_literal => true

# Game Class
class Game
  attr_reader :player1, :player2, :board

  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @board = Board.new
  end

  def move(player)
    puts "#{player.name}'s turn... Choose an open slot."
    move = gets.chomp
    board.update_grid(move.to_i, player.symbol)
  end

  def current_player
    board.total_moves.zero? || (board.total_moves % 2).zero? ? player1 : player2
  end

  def play_again
    puts "Wanna play another round?\nEnter 'y' or 'n'..."
    answer = gets.chomp.downcase
    until answer == 'y' || answer == 'n'
      puts "Enter a valid answer... 'y' or 'n'..."
      answer = gets.chomp.downcase
    end
    answer == 'y' ? @board = Board.new : quit_game
  end

  def quit_game
    puts "\nThanks for playing! See you next time!\n..."
    sleep(1)
    exit(0)
  end
end

# Board Class
class Board
  attr_reader :grid, :total_moves

  def initialize
    @grid = {
      1 => '1', 2 => '2', 3 => '3',
      4 => '4', 5 => '5', 6 => '6',
      7 => '7', 8 => '8', 9 => '9'
    }
    @total_moves = 0
    puts "Let's play... \n \n"
    sleep(1)
    show_grid
  end

  def show_grid
    puts "  #{grid[1]} * #{grid[2]} * #{grid[3]} \n
  #{grid[4]} * #{grid[5]} * #{grid[6]} \n
  #{grid[7]} * #{grid[8]} * #{grid[9]}"
  end

  def update_grid(slot, symbol)
    if grid[slot] == slot.to_s
      grid[slot] = symbol
      @total_moves += 1
      show_grid
      check_win
      check_draw
    else
      puts "Slot ##{slot} is already taken. \nPlease choose another slot..."
    end
  end

  def check_win
    lines = [
      [grid[1], grid[2], grid[3]], [grid[4], grid[5], grid[6]],
      [grid[7], grid[8], grid[9]], [grid[1], grid[4], grid[7]],
      [grid[2], grid[5], grid[8]], [grid[3], grid[6], grid[9]],
      [grid[1], grid[5], grid[9]], [grid[3], grid[5], grid[7]]
      ]
    lines.select do |line|
      if (line.uniq.count == 1) == true
        puts " \n Game Over! #{line[0]} wins!!!\n"
      end
    end
  end

  def check_draw
    draw = grid.values.map {|val| val.to_i}
    if draw.all?(0)
      puts " \n Game Over! It's a draw...\n"
    end
  end
end

# Player Class
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
