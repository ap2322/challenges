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
        (1..@size).each do |x|
            (1..@size).each do |y|
                unless @cells.find {|cell| cell.coordinates == [x,y]}
                    @cells.push(Cell.new([x,y]))
                end
            end
        end
    end

    def empty_cells
        @cells.find_all {|cell| cell.has_piece == false}
    end

    def obstacle_cells(queen)
        @ob_cells ||= cells.find_all do |cell|
            cell.has_piece && cell.coordinates != queen.cell.coordinates
        end
    end

    def obstacle_in_the_way(on_row, on_col, on_diag, queen, cell) 
        # returns true if there is an obstacle between the cell and queen
        # returns false if there is nothing between them
        obstacles = obstacle_cells(queen)
        case 
        when on_row
            obs_on_row = obstacles.find_all{|ob| ob.coordinates[0] == queen.cell.coordinates[0]}
            if obs_on_row.empty?
                return false
            else
                # is the cell closer to the queen than all the obstacles on the same row?
                obstacles_between = []
                
                obs_on_row.each do |ob|
                    if (ob.coordinates[1] < queen.cell.coordinates[1] && cell.coordinates[1] < queen.cell.coordinates[1]) ||
                        (ob.coordinates[1] > queen.cell.coordinates[1] && cell.coordinates[1] > queen.cell.coordinates[1]) 
                        obstacles_between << (ob.coordinates[1]..queen.cell.coordinates[1]).include?(cell.coordinates[1])
                    else
                        obstacles_between.push(true)
                    end
                end
                
                no_obstacles_between = obstacles_between.any?(true)
            end

        when on_col
            obs_on_col = obstacles.find_all{|ob| ob.coordinates[1] == queen.cell.coordinates[1]}
            
            if obs_on_col.empty?
                return false
            else
                # is the cell closer to the queen than all the obstacles on the same column?
                obstacles_between = []
                
                obs_on_col.each do |ob|
                    if (ob.coordinates[0] < queen.cell.coordinates[0] && cell.coordinates[0] < queen.cell.coordinates[0]) ||
                        (ob.coordinates[0] > queen.cell.coordinates[0] && cell.coordinates[0] > queen.cell.coordinates[0]) 
                        obstacles_between << (ob.coordinates[0]..queen.cell.coordinates[0]).include?(cell.coordinates[0])
                    else
                        obstacles_between.push(true)
                    end
                end
                
                no_obstacles_between = obstacles_between.any?(true)
            end
        when on_diag 
            return false

        else 


        end

    end
    
    def valid_queen_moves(queen)
        queen_coords = queen.cell.coordinates
        
        e_cells = empty_cells.map do |cell|
            on_row = cell.coordinates[0] == queen_coords[0]
            on_col = cell.coordinates[1] == queen_coords[1]
            on_diag = on_diag(queen_coords, cell.coordinates)

            if  on_row || on_col || on_diag
                unless obstacle_in_the_way(on_row, on_col, on_diag, queen, cell)
                    cell.coordinates
                end
            end
        end
        e_cells.compact
    end
    
    def on_diag(coord_1, coord_2)
        x_diff = (coord_1[0] - coord_2[0]).abs
        y_diff = (coord_1[1] - coord_2[1]).abs
        x_diff == y_diff
    end
end

# Complete the queensAttack function below.
def queensAttack(n, k, r_q, c_q, obstacles=[])
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
    
    # validate queen moves on board: 1. cell is empty 2. cell is on same row, column, or diagonal as queen 3. cell is not behind an obstacle relative to the queen
    queen_moves = board.valid_queen_moves(queen)
    queen_moves.length
    # Delete empty valid queen moves "past" obstacles on the board
    # moves_with_obstacles = board.valid_moves_with_obstacles(queen_moves, queen, obstacles)
    
end

# puts queensAttack(2, 2, 1, 1, [[0,0], [0,1]])
# puts queensAttack(4, 0, 4, 4)
# puts queensAttack(5, 4, 4, 3, [[5,5], [4,2], [2,3], [3,3]])
puts queensAttack(5, 3, 4, 3, [[5,5], [4,2], [2,3]])
