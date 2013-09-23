module Foil
  module Policy
    class Base
      attr_reader :person

      def initialize(person)
        @person = person
      end

      def scope(model)
        model if person.admin?
      end

      def write?(record)
        person.admin?
      end

      def delete?(record)
        person.admin?
      end

      def filter(model, values = {})
        values.select {|k,v| model.columns.any? { |c| c == k && k != :id } }
      end
    end
  end
end