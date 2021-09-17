# frozen-string-literal: true

def valid_position?(vector)
  vector.first.between?(0, 7) && vector.last.between?(0, 7)
end

def next_moves(position)
  return [] unless valid_position?(position)

  row_vectors    = [-2, -2, -1, -1, 2, 2, 1, 1]
  column_vectors = [-1, 1, -2, 2, -1, 1, 2, -2]

  vectors = 8.times.map do |i|
    [position.first + row_vectors[i], position.last + column_vectors[i]]
  end
  vectors.select { |vector| valid_position?(vector) }
end

def chess_position(vector)
  return unless valid_position?(vector)

  "#{('A'..'H').to_a[vector.last]}#{8 - vector.first}"
end

def print_moves(path)
  puts "\nYour Knight made it in #{path.length - 1} moves:"
  path[0..-2].each_with_index do |move, i|
    next_move = path[i + 1]
    puts " -> #{chess_position(move)} to #{chess_position(next_move)}" \
      " (#{move} to #{next_move})"
  end
end

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

def track_path(board, path)
  return if path.length < 2

  vectors = []
  (0..path.length - 2).each do |i|
    vectors += track_positions([path[i], path[i + 1]])
  end
  vectors.each { |vec| board.place(vec, "\e[0;32;49m●\e[0m") }
  path
end

def traverse(start, dest, queue)
  current = queue.shift
  return [dest] if current == dest

  children = next_moves(current)
  queue += children
  return traverse(start, current, [start]) << dest if children.include?(dest)

  traverse(start, dest, queue)
end

def knight_moves(start, dest, board = nil)
  vectors = traverse(start, dest, [start])

  if board
    vectors.each { |vector| board.place(vector, '🨄') }
    track_path(board, vectors)
    puts board
    print_moves(vectors)
  end
  vectors
end
