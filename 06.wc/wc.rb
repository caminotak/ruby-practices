#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

# 入力が文字列(標準入力、パイプライン)の場合のカウント
def count_word_string(string, option)
  output_lines = ''
  lines = string.count("\n")
  words = string.split(/\s+/).count # rubocopの指示によりreject(&:empty?).sizeより変更
  bytes = string.bytesize
  output_lines += lines.to_s.rjust(8)
  output_lines += option['l'] ? "\n" : "#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}\n"
end

# 入力がファイル名(引数)の場合のカウント
def count_word_files(files, option)
  output_files = ''
  total = { 'lines' => 0, 'words' => 0, 'bytes' => 0 }
  files.each do |filepath|
    str = File.read(filepath)
    lines = str.count("\n")
    words = str.split(/\s+/).size
    bytes = File.stat(filepath).size
    output_files += lines.to_s.rjust(8)
    output_files += option['l'] ? " #{filepath}\n" : "#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)} #{filepath}\n"
    total['lines'] += lines
    total['words'] += words
    total['bytes'] += bytes
  end
  [output_files, total]
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length.positive? # 引数にファイル名がある場合
    files = ARGV
    output, total = count_word_files(files, option)
  else # 引数がない場合(パイプライン、標準入力からの文字列)
    string = readlines.join
    output = count_word_string(string, option)
  end

  if files.length > 1 # 複数の引数があった場合にtotalを表示する行
    output += total['lines'].to_s.rjust(8).to_s
    output += option['l'] ? ' total' : "#{total['words'].to_s.rjust(8)}#{total['bytes'].to_s.rjust(8)} total"
  end
  puts output # 出力
end
