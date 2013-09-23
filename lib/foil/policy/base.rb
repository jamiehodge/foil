module Foil
  module Policy
    class Base
      attr_reader :person

      def initialize(person)
        @person = person
      end
    end
  end
end