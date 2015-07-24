class Board
  attr_reader :rows, :cols
  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @board = Array.new(rows) { Array.new(cols) }
  end

  def check_dimension(row, col)
    fail "row index #{row} is out of range (#{self.rows})" if row > self.rows
    fail "col index #{col} is out of range (#{self.cols})" if col > self.cols
  end

  def is_empty?(row, col)
    self.check_dimension(row, col)
    return @board[row - 1][col - 1].nil?
  end

  def at(row, col)
    self.check_dimension(row, col)
    return @board[row - 1][col - 1]
  end

  def place(row, col, piece)
    check_dimension(row, col)
    if is_empty?(row, col)
      @board[row - 1][col - 1] = piece
    else
      fail "#{@board[row - 1][col - 1]} currently occupies that slot."
    end
  end

  def remove(row, col)
    check_dimension(row, col)
    unless is_empty?(row, col)
      @board[row - 1][col - 1] = nil
    else
      fail "That slot is currently empty."
    end
  end

  def print_board
    @board.each do |row|
      row.each do |slot|
        print '|'
        slot.nil? ? print(' ') : print(slot)
      end
      puts '|'
    end
  end
end

# Don't change this code, either!
# See http://cl.ly/image/3t450Y271d25 for expected output
if __FILE__ == $PROGRAM_NAME
  board = Board.new(4, 4)
  board.place(1, 1, "X")
  board.place(2, 2, "O")
  board.place(3, 3, "X")
  board.place(4, 4, "#")

  board.print_board
end
