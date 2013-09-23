require_relative 'base'

module Foil
  module Model
    class PersonFolderPermission < Base
      many_to_one :folder
    end
  end
end

