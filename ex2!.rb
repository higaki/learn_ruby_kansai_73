a = [1, 2, 3, 5]

result = a.clone
result.select!{|i| i.odd?}

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
