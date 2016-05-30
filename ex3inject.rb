a = [1, 2, 3, 5]

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
