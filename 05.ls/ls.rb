#!/usr/bin/env ruby
# frozen_string_literal: true

names_original = Dir.glob('*') # コマンドを実行したディレクトリのファイル名の配列
display_columns = 3 # 表示列数

# メインのメソッド
def print_ls(names_original, display_columns)
  names_tabbed = tabbing_names(names_original) # タブ揃えされたされた文字列の配列
  display_lines = count_lines(names_tabbed, display_columns) # 表示行数
  names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
  display_lines.times do
    names_vertical << []
  end
  names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
    names_vertical[i % display_lines] << file.to_s
  end
  names_vertical.each { |w| puts w.join } # 出力
end

# 取得したファイル名にタブを追加して長さを揃える
def tabbing_names(names_original)
  tab_space = names_original.map(&:size).max / 8 + 1
  names_original.map do |w|
    w + "\t" * (tab_space - w.size / 8)
  end
end

# 取得した配列の要素数から表示行数を算出
def count_lines(names_tabbed, display_columns)
  (names_tabbed.size - 1) / display_columns + 1
end

print_ls(names_original, display_columns)
