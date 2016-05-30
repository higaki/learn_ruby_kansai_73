a = [1, 2, 3, 5]

a.select{|i| i.odd?}    # => [1, 3, 5]
a.select(&:odd?)        # => [1, 3, 5]

a.inject{|m, i| m + i}  # => 11
a.inject(&:+)           # => 11
a.inject(:+)            # => 11

# 2 * を to_proc
a.map(&2.method(:*))    # => [2, 4, 6, 10]
