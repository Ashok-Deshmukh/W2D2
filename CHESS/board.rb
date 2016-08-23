require_relative 'piece'
require_relative 'display'
require_relative 'cursor'
require_relative 'nullpiece'

class Board

  def initialize
    @grid = Array.new(8){Array.new(8)}
    set_up_board
  end

  def set_up_board_dummies
    (3..5).each do |row|
      (0..7).each do |col|
        pos = [row,col]
        self[pos]= NullPiece.instance
      end
    end
  end



  def [](pos)
    x, y = pos #write it out without syntactic sugar [0][1] etc.
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @grid[x][y] = val  #manually assign to grid on paper
  end

  def in_bounds?(pos)
    pos.all? {|coord| coord.between?(0,7)}
  end

  def has_piece?(color, pos)
    self[pos].color == color
  end

  def move_piece(start_pos, end_pos)
    raise if self[start_pos] == NullPiece.instance
    raise if self[end_pos] != NullPiece.instance
    self[end_pos] = self[start_pos]
    self[end_pos].current_pos = end_pos
    self[start_pos] = NullPiece.instance
  end





  def set_up_board
    self[[0,0]]= Rook.new([0,0], self, "white")
    self[[0,7]]= Rook.new([0,7], self, "white")
    self[[0,1]]= Knight.new([0,1], self, "white")
    self[[0,6]]= Knight.new([0,6], self, "white")
    self[[0,2]]= Bishop.new([0,2], self, "white")
    self[[0,5]]= Bishop.new([0,5], self, "white")
    self[[0,3]]= King.new([0,3], self, "white")
    self[[0,4]]= Queen.new([0,4], self, "white")
    (0..7).each { |y| self[[1,y]]=  Pawn.new([1,y], self, "white")}

    set_up_board_dummies

    self[[7,0]]= Rook.new([7,0], self, "black")
    self[[7,7]]= Rook.new([7,7], self, "black")
    self[[7,1]]= Knight.new([7,1], self, "black")
    self[[7,6]]= Knight.new([7,6], self, "black")
    self[[7,2]]= Bishop.new([7,2], self, "black")
    self[[7,5]]= Bishop.new([7,5], self, "black")
    self[[7,4]]= King.new([7,4], self, "black")
    self[[7,3]]= Queen.new([7,3], self, "black")
    (0..7).each { |y| self[[6,y]]=Pawn.new([6,y], self, "black")}
    # debugger
  end

end
