# frozen-string-literal: true

require_relative '../lib/knight_moves'
require_relative '../lib/chess_board'

describe 'KnightMoves' do
  RSPEC_BOARD = ChessBoard.new

  context 'valid_position?' do
    it 'should return whether the position is valid or not' do
      expect(valid_position?([6, 7])).to eq(true)
      expect(valid_position?([8, 1])).to eq(false)
    end
  end

  context 'next_moves' do
    it 'should return an array of possible next vectors' do
      expect(next_moves([0, 0])).to eq([[2, 1], [1, 2]])
      expect(next_moves([4, 4])).to eq(
        [[2, 3], [2, 5], [3, 2], [3, 6], [6, 3], [6, 5], [5, 6], [5, 2]]
      )
    end
  end

  context 'chess_position' do
    it 'should convert a vector to a chess position' do
      expect(chess_position([0, 0])).to eq('A8')
      expect(chess_position([3, 2])).to eq('C5')
    end
  end

  context 'print_moves' do
    it 'should print out the steps the knight took on its path' do
      expect { print_moves([[2, 3], [1, 1], [3, 0], [5, 1], [7, 0]]) }.to output(
        <<~OUTPUT

          Your Knight made it in 4 moves:
           -> D6 to B7 ([2, 3] to [1, 1])
           -> B7 to A5 ([1, 1] to [3, 0])
           -> A5 to B3 ([3, 0] to [5, 1])
           -> B3 to A1 ([5, 1] to [7, 0])
        OUTPUT
      ).to_stdout
    end
  end

  context 'track_positions' do
    it 'should return vectors for path marking of a single move' do
      expect(track_positions([[0, 0], [2, 1]])).to eq([[1, 0], [2, 0]])
    end
  end

  context 'track_path' do
    it 'should mark the path the knight took between two vectors on the board' do
      track_path(RSPEC_BOARD, [[0, 0], [2, 1], [3, 3]])
      marker = "\e[0;32;49m●\e[0m"
      expect(RSPEC_BOARD.fields[1][0]).to eq(marker)
      expect(RSPEC_BOARD.fields[2][0]).to eq(marker)
      expect(RSPEC_BOARD.fields[3][1]).to eq(marker)
      expect(RSPEC_BOARD.fields[3][2]).to eq(marker)
    end
  end

  context 'traverse' do
    it 'should find the shortest path the knight might take between two vectors' do
      expect(traverse([0, 0], [4, 5], [[0, 0]])).to eq([[0, 0], [2, 1], [3, 3], [4, 5]])
    end
  end

  context 'knight_moves' do
    it 'should return the shortest path between two vectors' do
      expect(knight_moves([0, 0], [3, 3])).to eq([[0, 0], [2, 1], [3, 3]])
    end

    it 'should place knights on the board if a board instance is passed in' do
      board = ChessBoard.new
      knight_moves([0, 0], [3, 3], board)
      expect(board.fields[0][0]).to eq('🨄')
      expect(board.fields[2][1]).to eq('🨄')
      expect(board.fields[3][3]).to eq('🨄')
    end
  end
end
