require_relative 'base'

module Foil
  module Model
    class File < Base
      many_to_one :category
      many_to_one :language
      many_to_one :license
      one_to_many :group_file_permissions
      one_to_many :person_file_permissions

      def person_ids
        Sequel.pg_array(super || [])
      end

      def add_person_id(id)
        update(person_ids: person_ids | [id]) unless id.blank?
      end

      def remove_person_id(id)
        update(person_ids: person_ids - [id])
      end
    end
  end
end

