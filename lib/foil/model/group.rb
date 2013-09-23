require_relative 'entry'

module Foil
  module Model
    class Group < Entry
      attr_reader :description, :person_ids

      def initialize(attrs)
        super
        @description = attrs.fetch(:description, '')
        @person_ids  = Array attrs[:person_ids]
      end
    end
  end
end

