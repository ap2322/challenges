require 'json'
require 'stringio'

def hourglassSum(arr)
    # make an hourglass 
        # start at 0,0 and grab coordinates that are 0,1; 0,2; 1,1; 0,2; 1,2; 2,2 into their own array
    hourglasses = {}
    hourglass = []
    arr.each_with_index do |row, i|
        if i < (arr.length - 2)
            row.each_with_index do |cell, idx|
                if idx < (row.length - 2)
                    hourglass.push(arr[i][idx], arr[i][idx+1], arr[i][idx+2])
                    hourglass.push(arr[i+1][idx+1])
                    hourglass.push(arr[i+2][idx], arr[i+2][idx+1], arr[i+2][idx+2])
                end
                hourglasses[hourglass] = hourglass.sum
                hourglass = []
            end
        end
    end
    require 'pry'; binding.pry
    hourglasses.delete([])
    hourglasses.values.max
end

file = "input2.txt"

file_data = File.read(file).split("\n")
arr = file_data.map do |line|
    line.split(" ").map(&:to_i)
end

puts hourglassSum(arr)

