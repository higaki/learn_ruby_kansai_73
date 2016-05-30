a = [1, 2, 3, 5]

result = a.clone
result.map!{|i| i * 2}

a           # => [1, 2, 3, 5]
result      # => [2, 4, 6, 10]
