# frozen-string-literal: true

require_relative 'trackable'

# chess knight class
class Knight
  include Trackable

  attr_reader :position, :moves
  attr_accessor :symbol

  MOVES = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]
  ].freeze

  def initialize(position = [0, 0], symbol = '🨄')
    @position = valid_position?(position) ? position : [0, 0]
    @symbol   = symbol
    @moves    = moveset
  end

  def knight_moves(destination, queue = [position])
    current = queue.shift
    return [destination] if current == destination

    children = moveset(current)
    return knight_moves(current) << destination if children.any?(destination)

    knight_moves(destination, queue + children)
  end

  private

  def moveset(position = self.position)
    return [] unless valid_position?(position)

    vectors = MOVES.map { |x, y| [position.first + x, position.last + y] }
    vectors.select { |vec| valid_position?(vec) }
  end

  def valid_position?(vector)
    vector.first.between?(0, 7) && vector.last.between?(0, 7)
  end
end
