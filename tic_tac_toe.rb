# frozen_string_literal => true

# Game Class
class Game
  attr_reader :player1, :player2, :board, :lines, :total_moves

  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @board = Board.new
    @total_moves = 0
  end

  def current_player
    total_moves.zero? || (total_moves % 2).zero? ? player1 : player2
  end

  def move(player)
    puts "\n#{player.name}'s turn... Choose an open slot Bro."
    move = gets.chomp
    update_grid(move.to_i, player.symbol)
  end

  def update_grid(slot, symbol)
    if board.grid[slot] == slot.to_s
      board.grid[slot] = symbol
      puts "\n#{current_player.name} marked slot ##{slot}: #{symbol}"
      @total_moves += 1
    else
      puts "Slot ##{slot} is already taken Bro. \nPlease choose another slot..."
    end
  end

  def win_lines(grid)
    @lines = [
      [grid[1], grid[2], grid[3]], [grid[4], grid[5], grid[6]],
      [grid[7], grid[8], grid[9]], [grid[1], grid[4], grid[7]],
      [grid[2], grid[5], grid[8]], [grid[3], grid[6], grid[9]],
      [grid[1], grid[5], grid[9]], [grid[3], grid[5], grid[7]]
      ]
  end

  def check_win
    win_lines(board.grid)
    lines.select do |line|
      if (line.uniq.count == 1) == true
        @total_moves += 1
        puts "\nGame Over Bro! #{line[0]} wins!!!\nCongratulations #{current_player.name}!!!"
        play_again
      end
    end
  end

  def check_draw
    draw = board.grid.values.map(&:to_i)
    return unless draw.all?(0)

    puts "\nGame Over Bro! It's a draw...\n"
    play_again
  end

  def board_refresh
    @board = Board.new
    @total_moves = 0
    board.show_grid
  end

  def play_again
    puts "\nWanna play another round Bro?\nEnter 'y' or 'n'..."
    answer = [gets.chomp.downcase]
    until answer.include?('y') || answer.include?('n')
      puts "Enter a valid answer... 'y' or 'n'..."
      answer = [gets.chomp.downcase]
    end
    answer.include?('y') ? board_refresh : quit_game
  end

  def quit_game
    puts "\nThanks for playing! See you next time Bro!\n..."
    sleep(1)
    exit(0)
  end
end

# Board Class
class Board
  attr_reader :grid

  def initialize
    @grid = {
      1 => '1', 2 => '2', 3 => '3',
      4 => '4', 5 => '5', 6 => '6',
      7 => '7', 8 => '8', 9 => '9'
    }
  end

  def show_grid
    puts "\n  #{grid[1]} * #{grid[2]} * #{grid[3]} \n
  #{grid[4]} * #{grid[5]} * #{grid[6]} \n
  #{grid[7]} * #{grid[8]} * #{grid[9]}"
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

# Game Play
puts "\nLet's play TIC - TAC - BRO!!!"
sleep(1)
game = Game.new
game.board.show_grid

while game.total_moves < 9
  game.move(game.current_player)
  game.board.show_grid
  game.check_win
  game.check_draw
end
