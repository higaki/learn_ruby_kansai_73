s = "No Ruby, No Life."

puts s.chars
  .each_with_object(Hash.new{|h, k| h[k] = 0}){|c, h| h[c] += 1}
  .sort_by{|c, n| [-n, c]}
  .map{|c, n| "%8d %s" % [n, c]}

# >>        3  
# >>        2 N
# >>        2 o
# >>        1 ,
# >>        1 .
# >>        1 L
# >>        1 R
# >>        1 b
# >>        1 e
# >>        1 f
# >>        1 i
# >>        1 u
# >>        1 y
