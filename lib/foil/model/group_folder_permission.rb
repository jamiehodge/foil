require_relative 'base'

module Foil
  module Model
    class GroupFolderPermission < Base
      many_to_one :folder
    end
  end
end

