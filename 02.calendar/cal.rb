#!/usr/bin/env ruby
require 'optparse'
require 'date'
options = ARGV.getopts('y:','m:')
year = options["y"].to_i
month = options["m"].to_i

# エラー入力の際に今日の日付を表示する設定
begin
date = Date.new(year, month, 1)
rescue
year = Date.today.year
month = Date.today.month
date_today = Date.today.mday
date = Date.new(year, month, 1)
end

# 月と年の表示/曜日の表示
puts date.strftime("%-m月%Y").center(20)
puts "日 月 火 水 木 金 土"

# 月によって異なる第１行のスペースを文字列にして配列に追加
day = date.strftime('%a')
monthly_date=[]
case day
    when "Mon"
    monthly_date.push("   ")
    when "Tue"
    2.times{monthly_date.push("   ")}
    when "Wed"
    3.times{monthly_date.push("   ")}
    when "Thu"
    4.times{monthly_date.push("   ")}
    when "Fri"
    5.times{monthly_date.push("   ")}
    when "Sat"
    6.times{monthly_date.push("   ")}
    end
# 配列の要素数を出力（カレンダーの出力行数を特定するため）
space=monthly_date.size
    
# 上記の配列に日付を月末日まで追加
n=0
lastdate = Date.new(year, month, -1)
while n < lastdate.mday
n += 1 
    if n < 10
    monthly_date.push("  #{n}")
    else 
    monthly_date.push(" #{n}")  
    end
end

# .joinのレシーバにnilないように空の文字列を追加
5.times{monthly_date.push"   "}

# 本日の日付の色を反転、本日の日付の桁数によって場合分け
if year == Date.today.year && month == Date.today.month
    if date_today < 10
    monthly_date[monthly_date.index("  #{date_today}")] = "  \e[30m\e[47m#{date_today}\e[0m"
    else
    monthly_date[monthly_date.index(" #{date_today}")] = " \e[30m\e[47m#{date_today}\e[0m"
    end
end

# shell出力部分 1-4行目
puts monthly_date[0..6].join[1..-1]
puts monthly_date[7..13].join[1..-1]
puts monthly_date[14..20].join[1..-1]
puts monthly_date[21..27].join[1..-1]

# shell出力部分 5行目以降
if space + lastdate.mday > 28
puts monthly_date[28..34].join[1..-1]
    if space + lastdate.mday > 35
    puts monthly_date[35..36].join[1..-1]
    end
end

