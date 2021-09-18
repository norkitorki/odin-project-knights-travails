# frozen_string_literal: true

require_relative '../lib/knight'
require_relative '../lib/chess_board'

describe Knight do
  KNIGHT = Knight.new

  it 'should initialize necessary state' do
    expect(KNIGHT.position).to eq([0, 0])
    expect(KNIGHT.symbol).to eq('🨄')
    expect(KNIGHT.moves).to eq([[1, 2], [2, 1]])
  end

  context 'moveset' do
    it 'should return possible moves from the current position' do
      expect(KNIGHT.moveset).to eq([[1, 2], [2, 1]])
    end

    it 'should return possible moves from passed in position' do
      expect(KNIGHT.moveset([2, 1])).to eq(
        [[0, 0], [0, 2], [1, 3], [3, 3], [4, 0], [4, 2]]
      )
    end
  end

  context 'knight_moves' do
    it 'should return the shortest path between two positions' do
      expect(KNIGHT.knight_moves([4, 5])).to eq([[0, 0], [1, 2], [2, 4], [4, 5]])
    end
  end

  context 'track_path' do
    it 'should place markers on a chess board to track the path of a knight' do
      board = ChessBoard.new
      marker = "\e[0;32;49m●\e[0m"
      KNIGHT.track_path(board, KNIGHT.knight_moves([3, 3]))
      expect(board.fields[1][0]).to eq(marker)
      expect(board.fields[1][1]).to eq(marker)
      expect(board.fields[2][2]).to eq(marker)
      expect(board.fields[3][2]).to eq(marker)
    end
  end
end
