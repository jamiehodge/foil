require_relative 'base'
require_relative '../model/file'

module Foil
  module Policy
    class File < Base
      def scope(model = Model::File)
        super || model.authored_by(person).union(permitted(person))
      end

      def write?(record)
        super || record.authored_by?(person) || record.permitted?(person, :write)
      end

      def delete?(record)
        super || record.permitted?(person, :delete)
      end
    end
  end
end

