#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def word_count(files)
  option = ARGV.getopts('l')
  if files.empty? # 引数がない場合（パイプラインから標準入力）
    str = readlines.join
    lines = str.count("\n")
    if option['l']
      puts lines.to_s.rjust(8).to_s
    else
      words = str.split(/\s+/).size
      bytes = str.bytesize
      puts "#{lines.to_s.rjust(8)}#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}"
    end
  else # 引数がある場合(引数、getsから標準入力)

    total_lines = 0
    total_words = 0
    total_bytes = 0

    files.each do |filepath|
      str = File.read(filepath)
      lines = str.count("\n")
      total_lines += lines
      if option['l']
        puts "#{lines.to_s.rjust(8)} #{filepath}"
      else
        words =  str.split(/\s+/).size
        bytes =  File.stat(filepath).size
        puts "#{lines.to_s.rjust(8)}#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)} #{filepath}"
        total_words += words
        total_bytes += bytes
      end
    end

    if files.length > 1
      print total_lines.to_s.rjust(8).to_s
      puts option['l'] ? ' total' : "#{total_words.to_s.rjust(8)}#{total_bytes.to_s.rjust(8)} total"
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    pipeline = readline
    if !pipeline.empty?# パイプライン入力がある場合
      files = []
    else # パイプライン記述がない場合、入力待ちになりこの分岐へ進まない
      puts 'ファイル名を入力して下さい >>'
      input = gets
      files = input.chomp.split
    end
  else
    files = ARGV
  end
  word_count(files)
end
