require_relative 'base'
require_relative '../model/group_file_permission'
require_relative '../model/person_file_permission'

module Foil
  module Policy
    class File < Base
      def scope(model)
        model
          .where(id: GroupFilePermission.where(group_id: person.group_ids).select(:id))
          .union(PersonFilePermission.where(person_id: person.id).select(:id))
      end

      def write?(record)
        super ||
        PersonFilePermission.where(person_id: person.id, file_id: record.id, write: true) ||
        GroupFilePermission.where(group_id: person.group_ids, file_id: record.id, write: true)
      end

      def delete?(record)
        super ||
        PersonFilePermission.where(person_id: person.id, file_id: record.id, delete: true) ||
        GroupFilePermission.where(group_id: person.group_ids, file_id: record.id, delete: true)
      end
    end
  end
end

