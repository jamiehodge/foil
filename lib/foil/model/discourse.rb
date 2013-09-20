require_relative 'base'

module Foil
  module Model
    class Discourse < Base
      many_to_many :folders
      one_to_many  :annotation
      one_to_many  :group_discourse_permissions
      one_to_many  :person_discourse_permissions
    end
  end
end

