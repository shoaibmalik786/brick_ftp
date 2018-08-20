require 'tempfile'

module Brickftp
  module Utils
    class ChunkIO
      include Enumerable

      attr_reader :io, :chunk_size

      def initialize(io, chunk_size: nil)
        @io = io
        @chunk_size = chunk_size
      end

      def each(&block)
        return enum_for(__method__) unless block
        whole(&block)
      end

      private

      def whole
        yield io
      end
    end
  end
end
