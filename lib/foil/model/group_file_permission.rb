require_relative 'base'

module Foil
  module Model
    class GroupFilePermission < Base
      many_to_one :file
    end
  end
end

