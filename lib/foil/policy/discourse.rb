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
    end
  end
end

