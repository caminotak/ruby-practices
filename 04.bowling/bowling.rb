#!/usr/bin/env ruby

scores_with_x = ARGV[0]
scores_without_x = scores_with_x.gsub(/X/, '10')
actual_throws = scores_without_x.split(',')

# 1-9
frames = []
9.times do
  frames << if actual_throws[0] == '10'
              [actual_throws.shift.to_i, 0]
            else
              actual_throws.shift(2).map(&:to_i)
            end
end

# 10
frames << actual_throws.map(&:to_i)

scores_by_frame = []

9.times do |n|
  scores_by_frame << if frames[n][0] == 10 && frames[n + 1][0] == 10
                       if n == 8
                         20 + frames[n + 1][1]
                       else
                         20 + frames[n + 2][0]
                       end
                     elsif frames[n][0] == 10
                       10 + frames[n + 1][0] + frames[n + 1][1]
                     elsif frames[n][0] + frames[n][1] == 10
                       10 + frames[n + 1][0]
                     else
                       frames[n].sum
                     end
end
scores_by_frame << frames[9].sum

p scores_by_frame.sum
