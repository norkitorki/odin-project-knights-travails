# frozen_string_literal: true

module Trackable
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
end
