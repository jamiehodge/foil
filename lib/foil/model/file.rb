require_relative 'base'
require_relative 'group_file_permission'
require_relative 'person_file_permission'

module Foil
  module Model
    class File < Base
      include Storable

      many_to_one :category
      many_to_one :language
      many_to_one :license
      one_to_many :issues
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

      dataset_module do

        def authored_by(person)
          where Sequel.pg_array(:person_ids).any(person)
        end

        def permitted(person, action = 'read')
          where id: GroupFilePermission.where(group_id: person.group_ids, action => true).select(:file_id)
            .union(PersonFilePermission.where(person_id: person.id, action => true).select(:file_id))
        end
      end

      def authored_by?(person)
        person_ids.include? person.id
      end

      def permitted?(person, action = :read)
        person_file_permissions_dataset[person_id: person.id, action => true] ||
          group_file_permissions_dataset[group_id: person.group_ids, action => true]
      end
    end
  end
end

