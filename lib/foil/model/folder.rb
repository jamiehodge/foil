require_relative 'base'

module Foil
  module Model
    class Folder < Base
      plugin :rcte_tree
      many_to_many :discourses
      many_to_many :files
      one_to_many :group_folder_permissions
      one_to_many :person_folder_permissions
    end
  end
end

