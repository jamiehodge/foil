module Foil
  module Model
    class Person

      attr_reader :id

      def self.[](id)
        new(id: id)
      end

      def initialize(values)
        @id = values.fetch(:id)
      end
    end
  end
end