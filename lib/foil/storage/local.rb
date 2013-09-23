require 'pathname'

module Foil
  module Storage
    class Local
      attr_reader :path

      def initialize(path)
        @path = Pathname(path).expand_path
      end

      def [](id)
        Collection.new(id, self)
      end

      private

      class Collection

        def initialize(id, storage)
          @id = id.to_s
          @storage = storage
        end

        def path
          @storage.path + @id
        end

        def [](id)
          if exist?(id)
            ::File.new file_path(id)
          else
            ::File.new ::File::NULL
          end
        end

        def []=(id, io, mode = 'w')
          io.rewind

          ::File.open(file_path(id), mode) do |f|
            f << io.read(4096) until io.eof?
          end
        end

        def delete(id)
          file_path(id).unlink if exist?(id)
        end

        def exist?(id)
          file_path(id).exist?
        end

        private

        def file_path(id)
          path + id.to_s
        end
      end
    end
  end
end