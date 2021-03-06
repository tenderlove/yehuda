module Yehuda
  class Database
    attr_accessor :page_size, :write_version, :read_version, :page_footer
    attr_accessor :itp_fraction, :btp_fraction, :btl_fraction
    attr_accessor :file_changes
    attr_reader :fh

    alias :to_io :fh

    def initialize file
      if String === file
        @fh = File.open file, File::RDWR
      else
        @fh = file
      end

      chk = @fh.read(16).force_encoding('UTF-8')
      raise "not a sqlite database" unless chk == header
      @page_size     = @fh.read(2).unpack('n').first
      @write_version = @fh.read(1).unpack('C').first
      @read_version  = @fh.read(1).unpack('C').first
      @page_footer   = @fh.read(1).unpack('C').first
      @itp_fraction  = @fh.read(1).unpack('C').first
      @btp_fraction  = @fh.read(1).unpack('C').first
      @btl_fraction  = @fh.read(1).unpack('C').first
      @file_changes  = @fh.read(2).unpack('n').first
    end

    private
    def header
      "SQLite format 3\u0000"
    end
  end
end
