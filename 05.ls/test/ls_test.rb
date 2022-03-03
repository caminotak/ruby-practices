# frozen_string_literal: true

require 'minitest/autorun'
require 'pathname'
require_relative '../lib/ls'

#LSコマンド、print_ls_no_optionメソッドを検証
class LSTest < Minitest::Test
  def test_ls1
    path = '/Users/takunaka'
    pathname = Pathname(path)
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
    assert_equal expected_output, print_ls_no_option(pathname, display_columns)
  end
end
