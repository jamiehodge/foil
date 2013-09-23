require_relative 'base'
require_relative '../model/discourse'

module Foil
  module Policy
    class Discourse < Base
      def scope(model = Model::Discourse)
        super || model.permitted(person)
      end

      def write?(record)
        super || record.permitted?(person, :write)
      end

      def delete?(record)
        super || record.permitted?(person, :delete)
      end
    end
  end
end

