require_relative 'base'

module Foil
  module Directory
    module LDAP
      class Group < Base
        def self.attributes
          super.merge(
            cn: :id, description: :description, memberuid: :person_ids)
        end

        def self.prefix
          'ou=group'
        end
      end
    end
  end
end

