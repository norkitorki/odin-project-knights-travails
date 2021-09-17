# frozen-string-literal: false

# chess board for knight_moves method
class ChessBoard
  attr_reader :fields

  def initialize
    @fields = Array.new(8) { Array.new(8, ' ') }
  end

  def place(vector, piece)
    return unless vector.first.between?(0, 7) && vector.last.between?(0, 7)

    fields[vector.first][vector.last] = piece
  end

  def to_s
    <<~BOARD
          ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        #{board_rows}
          ┗━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┛
            A   B   C   D   E   F   G   H
    BOARD
  end

  private

  def board_rows
    file = 9
    rows = fields.map { |row| "#{file -= 1} ┃ #{row.join(' │ ')}" }
    rows.join(" ┃\n  ┠───┼───┼───┼───┼───┼───┼───┼───┨\n") << ' ┃'
  end
end
