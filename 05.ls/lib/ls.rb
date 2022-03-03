#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'

# (オプションなし)出力用メソッド
def print_ls_no_option(pathname, display_columns)
  file_names = pathname.glob('*').map { |f| f.basename.to_s }
  names_tabbed = tabbing_names(file_names) # タブ揃えされたされた文字列の配列
  display_lines = count_lines(names_tabbed, display_columns) # 表示行数
  names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
  display_lines.times { names_vertical << [] }
  names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
    names_vertical[i % display_lines] << file
  end
  puts names_vertical.map(&:join).join("\n") # 出力
end

# (オプションなし)取得したファイル名にタブを追加して長さを揃える
def tabbing_names(file_names)
  max_space = file_names.map(&:size).max
  name_space = max_space + 8 - max_space % 8
  file_names.map { |w| w.ljust(name_space) }
end

# (オプションなし)取得した配列の要素数から表示行数を算出
def count_lines(names_tabbed, display_columns)
  (names_tabbed.size / display_columns).ceil
end

if __FILE__ == $PROGRAM_NAME
pathname = Pathname(Dir.pwd)
display_columns = 3.0 # 表示列数。count_linesメソッドで.ceilメソッドを使うため、Floatクラスにて記述
print_ls_no_option(pathname, display_columns)
end
