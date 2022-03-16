#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

# 出力用のメソッド
def word_count(files, pipeline, option)
  output = ''
  total = { 'lines' => 0, 'words' => 0, 'bytes' => 0 }
  if files.empty? # 引数がない場合（パイプラインから標準入力）
    output = wc_pipeline(pipeline, option)
  else # 引数がある場合(引数 or getsから標準入力)
    output_files, total = wc_files(files, option)
    output += output_files
  end

  if files.length > 1 # 複数の引数があった場合にtotalを表示する行
    output += total['lines'].to_s.rjust(8).to_s
    output += option['l'] ? ' total' : "#{total['words'].to_s.rjust(8)}#{total['bytes'].to_s.rjust(8)} total"
  end
  puts output
  output
end

def wc_pipeline(pipeline, option)
  output_lines = ''
  lines = pipeline.count("\n")
  words = pipeline.split(/\s+/).count # rubocopの指示によりreject(&:empty?).sizeより変更
  bytes = pipeline.bytesize
  output_lines += lines.to_s.rjust(8)
  output_lines += option['l'] ? "\n" : "#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}\n"
end

def wc_files(files, option)
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
  if ARGV.length.positive? # 引数がある場合
    files = ARGV
  elsif File.pipe?($stdin) # 引数がない場合
    pipeline = readlines.join
    files = []
  else # パイプライン記述がない場合、入力待ちになりこの分岐へ進まない。。。
    puts 'ファイル名を入力して下さい >>'
    input = gets
    files = input.chomp.split
  end
  word_count(files, pipeline, option) # 出力メソッド
end
