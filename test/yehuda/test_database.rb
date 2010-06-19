require 'yehuda'
require 'minitest/autorun'
require 'stringio'
require 'tempfile'

module Yehuda
  class TestDatabase < MiniTest::Unit::TestCase
    FILE = File.join(File.dirname(__FILE__), '..', 'files', 'file.sqlite3')

    def test_filename
      db = Yehuda::Database.new FILE
      assert_equal 1, db.write_version
      assert_equal 2048, db.page_size
    end

    def test_io
      fh = File.open(FILE, File::RDWR)

      db = Yehuda::Database.new fh
      assert_equal 1, db.write_version
      assert_equal 2048, db.page_size
      assert_equal fh, db.to_io
    end

    def test_stringio
      fh = StringIO.new File.binread(FILE)

      db = Yehuda::Database.new fh
      assert_equal 1, db.write_version
      assert_equal 2048, db.page_size
      assert_equal fh, db.to_io
    end

    def test_baddb
      s    = File.binread(FILE)
      s[0] = 'f'
      fh = StringIO.new s

      assert_raises(RuntimeError) do
        Yehuda::Database.new fh
      end
    end
  end
end
