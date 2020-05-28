def sherlockAndAnagrams(s)

    character_counts = {}

    s.split(//).each do |ch|
        if character_counts[ch]
            character_counts[ch] += 1
        else
            character_counts[ch] = 1
        end
    end
    require 'pry'; binding.pry

end

input = "abba"

puts sherlockAndAnagrams(input)

