# Ruby初級者向けレッスン 59回
## Array と Hash

### 演習問題1
map を使わずに Array のそれぞれの要素を 2倍した新しい Array を作ってみよう。

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
    ...
result              # => [2, 4, 6, 10]
````

### 演習問題2
select を使わずに Array から奇数の要素だけを抽出してみよう。

````ruby
a = [1, 2, 3, 5]

result = []
a.each do |i|
    ...
result              # => [1, 3, 5]
````

### 演習問題3
inject を使わずに Array の要素を合計してみよう。

````ruby
a = [1, 2, 3, 5]

result = 0
a.each do |i|
    ...
result              # => 11
````

### 演習問題4
* map を使って Array の各要素を 2倍してみよう。
* select を使って Array から奇数の要素だけを抽出してみよう。
* inject を使って Array の要素を合計してみよう。

````ruby
a = [1, 2, 3, 5]

a.map ...
a.select ...
a.inject ...
````

### 演習問題5
与えられた文字列から

* 単語の出現回数
* 文字の出現回数

を数えてみよう。