# fozen-string-literal: true

require_relative '../lib/chess_board'

describe ChessBoard do
  BOARD = ChessBoard.new

  context 'chess_position' do
    it 'should convert a vector to a chess position' do
      expect(ChessBoard.chess_position([0, 0])).to eq('A8')
    end
  end

  it 'should initialize necessary state' do
    expect(BOARD.fields).to eq(Array.new(8) { Array.new(8, ' ') })
  end

  context 'place' do
    it 'should place a string at the desired position' do
      BOARD.place([3, 4], '🨄')
      expect(BOARD.fields[3][4]).to eq('🨄')
    end

    it 'should return nil if the position is invalid' do
      expect(BOARD.place([10, 2], '🨄')).to eq(nil)
    end
  end

  context 'to_s' do
    it 'should print the chess board' do
      expect(BOARD.to_s).to eq(
        <<~BOARD
          ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        8 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        7 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        6 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        5 ┃   │   │   │   │ 🨄 │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        4 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        3 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        2 ┃   │   │   │   │   │   │   │   ┃
          ┠───┼───┼───┼───┼───┼───┼───┼───┨
        1 ┃   │   │   │   │   │   │   │   ┃
          ┗━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┛
            A   B   C   D   E   F   G   H
        BOARD
      )
    end
  end
end
