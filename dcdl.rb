class Dcdl
  def initialize(target)
    @target = target
  end

  def solve(numbers, backtrack = [])
    return backtrack if numbers.any? { |n| n == @target } || numbers.size == 1

    best = nil
    (0...numbers.size).each do |i|
      (i + 1...numbers.size).each do |j|
        rest = numbers[0...i] + numbers[i + 1...j] + numbers[j + 1..-1]
        poss = [
          { i: numbers[i], j: numbers[j], op: '+', res: numbers[i] + numbers[j] },
          { i: numbers[i], j: numbers[j], op: '*', res: numbers[i] * numbers[j] },
        ]
        if numbers[i] > numbers[j]
          poss << { i: numbers[i], j: numbers[j], op: '-', res: numbers[i] - numbers[j] }
        else
          poss << { i: numbers[j], j: numbers[i], op: '-', res: numbers[j] - numbers[i] }
        end
        if (numbers[j] > 0) && (numbers[i] % numbers[j] == 0)
          poss << { i: numbers[i], j: numbers[j], op: '/', res: numbers[i] / numbers[j] }
        elsif (numbers[i] > 0) && (numbers[j] % numbers[i] == 0)
          poss << { i: numbers[j], j: numbers[i], op: '/', res: numbers[j] / numbers[i] }
        end

        poss.each do |p|
          r = solve(rest + [p[:res]], backtrack + [p])
          if r && (best.nil? ||
            (r.size < best.size) ||
            ((r[-1][:res] - @target).abs < (best[-1][:res] - @target).abs ))
            best = r
          end
        end
      end
    end

    best
  end
end

if __FILE__ == $0
  puts Dcdl.new(ARGV[0].to_i).solve(ARGV[1..6].map(&:to_i)).inspect
end
