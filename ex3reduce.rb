a = [1, 2, 3, 5]

result = a.reduce{|m, i| m + i}

a           # => [1, 2, 3, 5]
result      # => 11
