a = [1, 2, 3, 5]

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
