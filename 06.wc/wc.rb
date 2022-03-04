#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

@option = ARGV.getopts('l')

# 出力用のメソッド
def word_count(files, pipeline)
  if files.empty? # 引数がない場合（パイプラインから標準入力）
    lines = pipeline.count("\n")
    words = pipeline.split(/\s+/).size
    bytes = pipeline.bytesize
    print lines.to_s.rjust(8).to_s
    print @option['l'] ? "\n" : "#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}\n"

  else # 引数がある場合(引数 or getsから標準入力)
    total = { 'lines' => 0, 'words' => 0, 'bytes' => 0 }
    files.each do |filepath|
      str = File.read(filepath)
      lines = str.count("\n")
      words =  str.split(/\s+/).size
      bytes =  File.stat(filepath).size
      print lines.to_s.rjust(8)
      print @option['l'] ? " #{filepath}\n" : "#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)} #{filepath}\n"
      total['lines'] += lines
      total['words'] += words
      total['bytes'] += bytes
    end

    if files.length > 1 # 複数の引数があった場合にtotalを表示する行
      print total['lines'].to_s.rjust(8).to_s
      puts @option['l'] ? ' total' : "#{total['words'].to_s.rjust(8)}#{total['bytes'].to_s.rjust(8)} total"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length > 0 # 引数がある場合
    files = ARGV
  else # 引数がない場合
    pipeline = readlines.join
    if !pipeline.empty? # パイプライン入力がある場合
      files = []
    else # パイプライン記述がない場合、入力待ちになりこの分岐へ進まない。。。
      puts 'ファイル名を入力して下さい >>'
      input = gets
      files = input.chomp.split
    end
  end
  word_count(files, pipeline) # 出力メソッド
end
