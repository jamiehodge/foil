require_relative 'base'
require_relative '../model/group_discourse_permission'
require_relative '../model/person_discourse_permission'

module Foil
  module Policy
    class Discourse < Base
      def scope(model)
        model
          .where(id: GroupDiscoursePermission.where(group_id: person.group_ids).select(:id))
          .union(PersonDiscoursePermission.where(person_id: person.id).select(:id))
      end

      def write?(record)
        super ||
        PersonDiscoursePermission.where(person_id: person.id, discourse_id: record.id, write: true) ||
        GroupDiscoursePermission.where(group_id: person.group_ids, discourse_id: record.id, write: true)
      end

      def delete?(record)
        super ||
        PersonDiscoursePermission.where(person_id: person.id, discourse_id: record.id, delete: true) ||
        GroupDiscoursePermission.where(group_id: person.group_ids, discourse_id: record.id, delete: true)
      end
    end
  end
end

