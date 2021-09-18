# frozen-string-literal: true

# chess knight class
class Knight
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

  def moveset(position = self.position)
    return [] unless valid_position?(position)

    vectors = MOVES.map { |x, y| [position.first + x, position.last + y] }
    vectors.select { |vec| valid_position?(vec) }
  end

  def knight_moves(destination, queue = [position])
    current = queue.shift
    return [destination] if current == destination

    children = moveset(current)
    return knight_moves(current) << destination if children.any?(destination)

    knight_moves(destination, queue + children)
  end

  def track_path(board, path)
    return if path.length < 2

    vectors = []
    (0..path.length - 2).each do |i|
      vectors += track_positions([path[i], path[i + 1]])
    end
    vectors.each { |vec| board.place(vec, "\e[0;32;49m●\e[0m") }
    path
  end

  private

  def track_positions(move)
    (1..2).map do |i|
      if (move[0].first - move[1].first).abs == 2
        min = move.min_by(&:first)
        [min.first + i, min.last]
      else
        max = move.max_by(&:last)
        [max.first, max.last - i]
      end
    end
  end

  def valid_position?(vector)
    vector.first.between?(0, 7) && vector.last.between?(0, 7)
  end
end
