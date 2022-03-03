#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'

# (オプションなし)出力用メソッド
def print_ls_no_option(names_original, display_columns)
  names_tabbed = tabbing_names(names_original) # タブ揃えされたされた文字列の配列
  display_lines = count_lines(names_tabbed, display_columns) # 表示行数
  names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
  display_lines.times { names_vertical << [] }
  names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
    names_vertical[i % display_lines] << file
  end
  $stdout.puts names_vertical.map(&:join).join("\n") # 出力
end

# (オプションなし)取得したファイル名にタブを追加して長さを揃える
def tabbing_names(names_original)
  max_space = names_original.map(&:size).max
  name_space = max_space + 8 - max_space % 8
  names_original.map { |w| w.ljust(name_space) }
end

# (オプションなし)取得した配列の要素数から表示行数を算出
def count_lines(names_tabbed, display_columns)
  (names_tabbed.size / display_columns).ceil
end

# 実行

if __FILE__ == $PROGRAM_NAME
  names_original =
    if ARGV.empty?
      Dir.glob('*')
    elsif File.stat(*ARGV).ftype == 'directory'
      Dir.entries(*ARGV).sort[2..-1]
    elsif File.stat(*ARGV).ftype == 'file'
      Dir.glob(*ARGV)
    end
  display_columns = 3.0 # 表示列数。count_linesメソッドで.ceilメソッドを使うため、Floatクラスにて記述
end

print_ls_no_option(names_original, display_columns)
