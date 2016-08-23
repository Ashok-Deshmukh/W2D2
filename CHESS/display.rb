require_relative 'board'
require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :board, :cursor
  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    rows = (0...8).map do |row|
      (0...8).map do |col|
        if [row, col] == @cursor.cursor_pos
          # debugger
          @board[[row, col]].to_s.colorize(:green)
        else
          @board[[row, col]].to_s
        end
      end.join(" ")
    end
    puts rows.join(" \n")
  end

end



if __FILE__ == $PROGRAM_NAME
  d = Display.new
  d.render
  d.board[[0,1]].possible_moves
  d.render
end
