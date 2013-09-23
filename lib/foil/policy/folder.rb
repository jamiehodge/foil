require_relative 'base'
require_relative '../model/group_folder_permission'
require_relative '../model/person_folder_permission'

module Foil
  module Policy
    class Folder < Base
      def scope(model)
        model
          .where(id: GroupFolderPermission.where(group_id: person.group_ids).select(:id))
          .union(PersonFolderPermission.where(person_id: person.id).select(:id))
      end
    end
  end
end

