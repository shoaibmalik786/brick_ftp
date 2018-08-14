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
        if chunk_size
          each_chunk(&block)
        else
          whole(&block)
        end
      end

      private

      def whole
        yield io
      end

      def each_chunk
        eof = false
        offset = 0
        until eof
          Tempfile.create('chunk-io') do |chunk|
            copied = IO.copy_stream(io, chunk, chunk_size, offset)
            eof = copied.zero?
            next if eof
            offset += copied
            chunk.rewind
            yield chunk
          end
        end
      end
    end
  end
end
