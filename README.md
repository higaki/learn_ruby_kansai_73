# Ruby初級者向けレッスン 59回
## Array と Hash

### 演習問題1
`Enumerable#map` を使わずに Array のそれぞれの要素を 2倍した新しい Array を作ってみよう。

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
    ...
result              # => [2, 4, 6, 10]
````

#### 解答例

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
  result << i * 2
end

a           # => [1, 2, 3, 5]
result      # => [2, 4, 6, 10]
````

### 演習問題2
`Enumerable#select` を使わずに Array から奇数の要素だけを抽出してみよう。

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
    ...
result              # => [1, 3, 5]
````

#### 解答例

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
  result << i if i.odd?
end

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
````

### 演習問題3
`Enumerable#inject` を使わずに Array の要素を合計してみよう。

````ruby
a = [1, 2, 3, 5]

result = 0
a.each do |i|
    ...
result              # => 11
````

#### 解答例

````ruby
a = [1, 2, 3, 5]

result = 0
a.each do |i|
  result += i
end

a           # => [1, 2, 3, 5]
result      # => 11
````

### 演習問題4
* `Enumerable#map` を使って Array の各要素を 2倍してみよう。
* `Enumerable#select` を使って Array から奇数の要素だけを抽出してみよう。
* `Enumerable#inject` を使って Array の要素を合計してみよう。

````ruby
a = [1, 2, 3, 5]

a.map ...
a.select ...
a.inject ...
````

#### 解答例

````ruby
a = [1, 2, 3, 5]

a.map{|i| i * 2}        # => [2, 4, 6, 10]
a.select{|i| i.odd?}    # => [1, 3, 5]
a.inject{|m, i| m + i}  # => 11
````

### 演習問題5
与えられた文字列から

* 単語の出現回数
* 文字の出現回数

を数えてみよう。

#### 解答例: 単語の出現回数

````ruby
s = "No Ruby, No Life."

puts s.scan(/\p{Word}+/)
  .each_with_object(Hash.new{|h, k| h[k] = 0}){|w, h| h[w] += 1}
  .sort_by{|w, n| [-n, w]}
  .map{|w, n| "%8d %s" % [n, w]}

# >>        2 No
# >>        1 Life
# >>        1 Ruby
````

1. `String#scan` で文字列を単語に分割
1. Hash に集計
1. 出現回数の多い順、単語の辞書順にソート
1. 「出現回数 単語」の形式に整形

#### 解答例: 文字の出現回数

````ruby
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
````

1. `String#chars` で文字列を文字に分割
1. Hash に集計
1. 出現回数の多い順、文字の辞書順にソート
1. 「出現回数 文字」の形式に整形
