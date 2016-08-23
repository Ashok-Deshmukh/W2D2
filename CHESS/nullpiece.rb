require 'singleton'

class NullPiece
  include Singleton

  attr_accessor :color, :value

  def initialize
    @color = nil
    @value = "_"
  end

  def to_s
    @value
  end

end
