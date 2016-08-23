require 'colorize'
require 'byebug'


class Piece
  attr_accessor :color, :board, :current_pos, :value

  def initialize(pos, board, color)
    @current_pos = pos
    @color = color
    @board = board
  end

  def to_s
    @value
  end

  # def moves
  # end
  def sum_coordinates(old_position, shift)
    [(old_position[0] + shift[0]), (old_position[1] + shift[1])]
  end

  def edge_board?(pos)
    !@board.in_bounds?(pos)
  end

  def move_invalid?(color,next_tile)

    edge_board?(next_tile) || @board.has_piece?(color, next_tile)

  end


end


class SlidingPiece < Piece



  HORIZONTAL = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  DIAGONAL = {
    nw: [-1, 1],
    sw: [-1,-1],
    se: [1, -1],
    ne: [1, 1]
  }

  def grow_paths(shift) #[path]n shift = change in x,y; modify to check color; returns array of arrays, some will be empty
    path = []
    this_tile = @current_pos

    # sub_direction.each do |shift|
      loop do
        next_tile = sum_coordinates(this_tile, shift)

        break if move_invalid?(color,next_tile)
        path << next_tile
        this_tile = next_tile
      end
    # end
    path
  end




  def moves
    # debugger
    all_possible_paths = []
    move_dirs.each do |direction|
      direction.each do |_ ,v|
       all_possible_paths << grow_paths(v)
    end
  end
    all_possible_paths
  end


end

class Rook < SlidingPiece

  def initialize(pos, board, color)
    super
    @value = "R"
  end

  def move_dirs
    [HORIZONTAL]
  end


end



class Bishop < SlidingPiece
  def initialize(pos, board, color)
    super
    @value = "B"
  end

  def move_dirs
    [DIAGONAL]
  end

end


class Queen < SlidingPiece
  def initialize(pos, board, color)
    super
    @value = "Q"
  end

  def move_dirs
    [HORIZONTAL, DIAGONAL]
  end

end



class SteppingPiece < Piece

end

class King < SteppingPiece

  KING_STEPS = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def initialize(pos, board, color)
    super
    @value = "K"
  end

  def possible_moves
    moves = []
    this_tile = @current_pos

    KING_STEPS.each do |_ , shift|
      next_tile = sum_coordinates(this_tile, shift)
      next if move_invalid?(color,next_tile)
      moves << next_tile
      this_tile = next_tile
    end
    moves
  end


end

class Knight < SteppingPiece
  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def initialize(pos, board, color)
    super
    @value = "N"
  end

  def possible_moves
    valid_moves = []

    MOVES.each do |new_coord|
      next_tile = sum_coordinates(@current_pos, new_coord)
      next if move_invalid?(color,next_tile)
      valid_moves << next_tile
    end
    valid_moves
  end

end

class Pawn < Piece
  def initialize(pos, board, color)
    super
    @value = "P"
  end

end
