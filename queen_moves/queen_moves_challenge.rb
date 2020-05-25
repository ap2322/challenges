class Piece
    attr_reader :cell, :is_queen

    def initialize(row_column_array, is_queen=false)
        @cell = Cell.new(row_column_array, true)
        @is_queen = is_queen
    end

end

class Cell 
    attr_reader :coordinates, :has_piece

    def initialize(row_column_array, has_piece=false)
        @coordinates = row_column_array
        @has_piece = has_piece 
    end
end

class Board
    attr_reader :cells
    def initialize(size)
        @size = size
        @cells = []
    end

    def add_cell(cell)
        @cells.push(cell)
    end

    def fill_in_empty_cells
        @size.times do |x|
            @size.times do |y|
                unless @cells.find {|cell| cell.coordinates == [x,y]}
                    @cells.push(Cell.new([x,y]))
                end
            end
        end
    end

    def empty_cells
        @cells.find_all {|cell| cell.has_piece == false}
    end

    def valid_queen_moves(queen)
        queen_coords = queen.cell.coordinates
        empty_cells.map do |cell|
            on_row = cell.coordinates[0] == queen_coords[0]
            on_col = cell.coordinates[1] == queen_coords[1]

            if  on_row || on_col || on_diag(queen_coords, cell.coordinates)
                cell.coordinates
            end
        end
    end

    def on_diag(queen_coords, cell_coords)
        x_diff = (queen_coords[0] - cell_coords[0]).abs
        y_diff = (queen_coords[1] - cell_coords[1]).abs
        x_diff == y_diff
    end
end

# Complete the queensAttack function below.
def queensAttack(n, k, r_q, c_q, obstacles)
    # make board
    board = Board.new(n)
    # make pieces and add to board immediately after creating
    queen = Piece.new([r_q, c_q], true)
    board.add_cell(queen.cell)

    obstacle_pieces = []
    obstacles.each do |ob|
        obstacle_piece = Piece.new(ob)
        board.add_cell(obstacle_piece.cell)
        obstacle_pieces.push(obstacle_piece)
    end

    # fill in the empty cells of the board
    board.fill_in_empty_cells

    # find all empty cells on the board
    empty_cells = board.empty_cells

    # validate queen moves on board: 1. cell is empty 2. cell is on same row, column, or diagonal as queen
    queen_moves = board.valid_queen_moves(queen)
   require 'pry'; binding.pry
end

queensAttack(2, 2, 1, 1, [[0,0], [0,1]])
