require_relative 'base'

module Foil
  module Model
    class GroupDiscoursePermission < Base
      many_to_one :discourse
    end
  end
end

