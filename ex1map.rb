a = [1, 2, 3, 5]

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
