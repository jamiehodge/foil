require_relative 'base'
require_relative 'group_folder_permission'
require_relative 'person_folder_permission'

module Foil
  module Model
    class Folder < Base
      plugin :rcte_tree
      many_to_many :discourses
      many_to_many :files
      one_to_many :group_folder_permissions
      one_to_many :person_folder_permissions

      dataset_module do
        def permitted(person, action = :read)
          where(id: GroupFolderPermission.where(group_id: person.group_ids, action => true).select(:folder_id)
            .union(PersonFolderPermission.where(person_id: person.id, action => true).select(:folder_id)))
        end
      end

      def permitted?(person, action = :read)
        person_folder_permissions_dataset[person_id: person.id, action => true] ||
          group_folder_permissions_dataset[group_id: person.group_ids, action => true]
      end
    end
  end
end

