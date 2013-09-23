require_relative 'base'
require_relative '../model/folder'

module Foil
  module Policy
    class Folder < Base
      def scope(model = Model::Folder)
        super || model.permitted(person, :read)
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

