# Responsible for:
#     -Adding player marks
#     -Checking for winners
#     -Printing the game board

class Board
  def initialize(i_grid_size)
    # Rubys way of initializing a 2d array. Each array starts with _ that symbolizes empty space
    @a_grid = Array.new(i_grid_size) { Array.new(i_grid_size, '_') }
  end

  def valid?(a_position)
    return false if a_position[0] >= @a_grid.length || a_position[1] >= @a_grid.length

    true
  end

  def empty?(a_position)
    return true if @a_grid[a_position[0]][a_position[1]] == '_'

    false
  end

  def place_mark(a_position, c_mark)
    raise 'out_of_bounds' unless valid?(a_position)
    raise 'not_empty' unless empty?(a_position)

    @a_grid[a_position[0]][a_position[1]] = c_mark
  end

  def print
    @a_grid.each do |line|
      line.each_with_index do |symbol, index|
        IO.console.print symbol
        IO.console.print ' ' if index < @a_grid.length - 1
      end
      IO.console.print "\n"
    end
  end

  def win_row?(c_mark)
    @a_grid.each do |line|
      condition = true
      line.each { |symbol| condition = false if c_mark != symbol }
      return condition if condition
    end
    false
  end

  def win_col?(c_mark)
    (0...@a_grid.length).each do |i|
      condition = true
      (0...@a_grid.length).each do |j|
        condition = false if @a_grid[j][i] != c_mark
      end
      return condition if condition
    end
    false
  end

  def win_diagonal?(c_mark)
    condition1 = true
    condition2 = true
    # iterate one diagonal
    (0...@a_grid.length).each do |j|
      condition1 = false if @a_grid[j][j] != c_mark
      (0...@a_grid.length).reverse_each do |f|
        condition2 = false if @a_grid[f][j] != c_mark
      end
    end
    condition1 || condition2
  end

  def win?(c_mark)
    win_diagonal?(c_mark)||win_col?(c_mark)||win_row?(c_mark)
  end
end
