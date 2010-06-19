module Yehuda
  class Database
    attr_accessor :page_size, :write_version

    def initialize file
      if File.exists? file
        @fh = File.open file, File::RDWR
        chk = @fh.read(16).force_encoding('UTF-8')
        raise "not a sqlite database" unless chk == header

        @page_size     = @fh.read(2).unpack('n').first
        @write_version = @fh.read(1).unpack('C').first
      else
        @fh        = File.open file, File::RDWR | File::CREAT
        @page_size = 2048
      end
    end

    private
    def header
      "SQLite format 3\u0000"
    end
  end
end
