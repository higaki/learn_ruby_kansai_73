a = [1, 2, 3, 5]

result = []
a.each do |i|
  result << i if i.odd?
end

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
