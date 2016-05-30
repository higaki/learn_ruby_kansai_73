a = [1, 2, 3, 5]

result = a.find_all{|i| i.odd?}

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
