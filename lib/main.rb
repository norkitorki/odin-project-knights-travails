# frozen-string-literal: true

require_relative 'chess_board'
require_relative 'knight_moves'

BOARD = ChessBoard.new

# example

p knight_moves([2, 3], [7, 0], BOARD)
