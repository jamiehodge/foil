require_relative 'base'

module Foil
  module Directory
    module LDAP
      class Person < Base
        def self.attributes
          super.merge(
            uid: :id,
            displayname: :name,
            title: :title,
            o: :organization,
            departmentnumber: :department,
            mail: :mail,
            ismemberof: :group_ids
            )
        end

        def self.authenticate(id, password)
          result = directory.bind_as(
            base: base,
            filter: Net::LDAP::Filter.eq(attributes.invert[:id],id),
            attributes: attributes.keys,
            password: password
          )
          new(result.first) if result
        end

        def self.prefix
          'ou=people'
        end

        def to_h
          super.merge(
            group_ids: Array(attrs[:ismemberof]).map {|dn| dn[/^cn=(.+?),/, 1] }
            )
        end
      end
    end
  end
end

