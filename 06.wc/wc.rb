#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

if ARGV.empty?
  str = readlines.join
  lines = str.lines.count
  if option['l']
    puts lines.to_s.rjust(8).to_s
  else
    words = str.split(/\s+/).size
    bytes = str.bytesize
    puts "#{lines.to_s.rjust(8)}#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}"
  end
else

  total_lines = 0
  total_words = 0
  total_bytes = 0

  ARGV.each do |filepath|
    str = File.read(filepath)
    lines = str.lines.count
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

  if ARGV[1]
    print total_lines.to_s.rjust(8).to_s
    puts option['l'] ? ' total' : "#{total_words.to_s.rjust(8)}#{total_bytes.to_s.rjust(8)} total"
  end

end
