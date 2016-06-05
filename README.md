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

#### 解答例: map がないなら map! を使えばいいじゃない

````ruby
result = a.clone
result.map!{|i| i * 2}

a           # => [1, 2, 3, 5]
result      # => [2, 4, 6, 10]
````

`Array#map!` も使用禁止です。


#### 解答例: map の別名は collect

````ruby
result = a.collect{|i| i * 2}

a           # => [1, 2, 3, 5]
result      # => [2, 4, 6, 10]
````

もちろん `Enumerable#collect` も `Array#collect!` も使用禁止。


#### 解答例: map を実装してみた

````ruby
module RubyKansai
  refine Array do
    def _map_
      unless block_given?
        to_enum __callee__
      else
        inject([]) do |result, item|
          result << yield(item)
        end
      end
    end
  end
end

using RubyKansai
result = a._map_{|i| i * 2}

a           # => [1, 2, 3, 5]
result      # => [2, 4, 6, 10]
````

……そうじゃない


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

#### 解答例: select がないなら select! を(ry

````ruby
result = a.clone
result.select!{|i| i.odd?}

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
````

`Array#select!` も使用禁止。


#### 解答例: select の別名は find_all

````ruby
result = a.find_all{|i| i.odd?}

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
````

`Enumerable#find_all` も使用禁止。

#### 解答例: select を実装してみた (ｷﾘｯ

````ruby
module RubyKansai
  refine Array do
    def _select_
      unless block_given?
        to_enum __callee__
      else
        each_with_object([]) do |item, result|
          result << item if yield(item)
        end
      end
    end
  end
end

using RubyKansai
result = a._select_{|i| i.odd?}

a           # => [1, 2, 3, 5]
result      # => [1, 3, 5]
````

だから、そうじゃない!


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


#### 解答例: inject の別名は reduce

````ruby
result = a.reduce{|m, i| m + i}

a           # => [1, 2, 3, 5]
result      # => 11
````

`Enumerable#reduce` も(ry


#### 解答例: inject を(ry

````ruby
module RubyKansai
  refine Array do
    def _inject_(*args, &block)
      block = args.pop.to_proc if args.last.instance_of? Symbol
      item = each
      begin
        result = args.empty? ? item.next : args.first
        loop do
          result = block.call(result, item.next)
        end
        result
      rescue StopIteration
        nil
      end
    end
  end
end

using RubyKansai
result = a._inject_{|m, i| m + i}

a           # => [1, 2, 3, 5]
result      # => 11
````

そうじゃない!!


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

#### 解答例: method を to_proc

````ruby
a.select{|i| i.odd?}    # => [1, 3, 5]
a.select(&:odd?)        # => [1, 3, 5]

a.inject{|m, i| m + i}  # => 11
a.inject(&:+)           # => 11
a.inject(:+)            # => 11

# 2 * を to_proc
a.map{|i| i * 2}        # => [2, 4, 6, 10]
a.map(&2.method(:*))    # => [2, 4, 6, 10]
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
