def countSwaps(a)
    n = a.length - 1
    counter = 0
    n.times do |i|
        n.times do |j|
            if a[j] > a[j+1]
                temp = a[j]
                a[j] = a[j+1]
                a[j+1] = temp
                counter += 1
            end
        end
    end
    puts "counter #{counter}"

end

countSwaps([2,3,1])