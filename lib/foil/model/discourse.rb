require_relative 'base'
require_relative 'group_discourse_permission'
require_relative 'person_discourse_permission'

module Foil
  module Model
    class Discourse < Base
      many_to_many :folders
      one_to_many  :utterances
      one_to_many  :group_discourse_permissions
      one_to_many  :person_discourse_permissions

      dataset_module do
        def permitted(person, action)
          where(id: GroupDiscoursePermission.where(group_id: person.group_ids, action => true).select(:discourse_id)
            .union(PersonDiscoursePermission.where(person_id: person.id, action => true).select(:discourse_id)))
        end
      end

      def permitted?(person, action)
        person_discourse_permissions_dataset[person_id: person.id, action => true] ||
          group_discourse_permissions_dataset[group_id: person.group_ids, action => true]
      end
    end
  end
end

