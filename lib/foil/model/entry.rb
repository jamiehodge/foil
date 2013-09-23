module Foil
  module Model
    class Entry
      class << self
        attr_accessor :directory

        def [](id)
          entry = directory[id]
          new(entry.to_h) if entry
        end

        def search(query)
          directory.search(query).map {|entry| new(entry.to_h) }
        end
      end

      attr_reader :id

      def initialize(attrs)
        @id = attrs.fetch(:id)
      end
    end
  end
end