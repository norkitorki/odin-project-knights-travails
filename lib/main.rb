# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'knight'

# initialize the ChessBoard
BOARD = ChessBoard.new
# initialize the Knight at position [0, 7]
KNIGHT = Knight.new([0, 7])

# find the shortest path to position [6, 1]
path = KNIGHT.knight_moves([6, 1])
# place a knight on the board at each position the knight traverses over
path.each { |position| BOARD.place(position, KNIGHT.symbol) }
# place track markers on the board to visualize the knight's path
KNIGHT.track_path(BOARD, path)
# print the board
puts BOARD

# print out each of the knight's moves
puts "The Knight made it in #{path.length - 1} moves:"
path[0..-2].each_with_index do |vec, i|
  next_vec = path[i + 1]
  puts "#{ChessBoard.chess_position(vec)} to #{ChessBoard.chess_position(next_vec)} (#{vec} to #{next_vec})"
end
