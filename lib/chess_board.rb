# frozen-string-literal: true

# chess board class
class ChessBoard
  attr_reader :fields

  def self.chess_position(vector)
    "#{('A'..'H').to_a[vector.last]}#{8 - vector.first}"
  end

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
