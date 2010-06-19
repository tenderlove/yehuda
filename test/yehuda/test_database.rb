require 'yehuda'
require 'minitest/autorun'

module Yehuda
  class TestDatabase < MiniTest::Unit::TestCase
    FILE = File.join(File.dirname(__FILE__), '..', 'files', 'file.sqlite3')

    def test_filename
      db = Yehuda::Database.new FILE
      assert_equal 1, db.write_version
      assert_equal 2048, db.page_size
    end
  end
end
