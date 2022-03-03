# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../ls'

#LSコマンド、print_ls_no_optionメソッドを検証
class LSTest < Minitest::Test
  def test_ls1
    path = '/Users/takunaka'
    names_original = Dir.entries(path).sort[2..-1]
    display_columns = 3.0

    expected_output = <<~TEXT
      Applications    Movies          echo
      Calibre Library Music           gittutorial
      Desktop         Pictures        hello-world
      Documents       Public          hotger
      Downloads       TEST            patchwork
      FBC             TEST2           result
      Gemfile         VirtualBox VMs  rubybook
      Gemfile.lock    Wine Files      tutor
      Library         bin             work
    TEXT

    assert_equal expected_output, print_ls_no_option(names_original, display_columns)
  end
end
