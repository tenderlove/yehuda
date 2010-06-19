module Yehuda
  class Database
    attr_accessor :page_size, :write_version
    attr_reader :fh

    alias :to_io :fh

    def initialize file
      if IO === file
        @fh = file
      else
        @fh = File.open file, File::RDWR
      end

      chk = @fh.read(16).force_encoding('UTF-8')
      raise "not a sqlite database" unless chk == header
      @page_size     = @fh.read(2).unpack('n').first
      @write_version = @fh.read(1).unpack('C').first
    end

    private
    def header
      "SQLite format 3\u0000"
    end
  end
end
