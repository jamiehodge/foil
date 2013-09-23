require 'net-ldap'

module Foil
  module Directory
    module LDAP
      class Base
        def self.[](id)
          search(id: id).first
        end

        def self.search(query)
          q = query.each_with_object({}) {|(k,v),h| h[attributes.invert[k]] = v}

          Array(directory.search(
            base: base,
            filter: q.map {|(k,v)|
              Array(v).map {|v|
                Net::LDAP::Filter.begins(k,v)
              }.reduce(:|)
            }.reduce(:&),
            attributes: attributes.keys
          )).map {|attrs| new(attrs) }
        end

        attr_reader :attrs

        def initialize(attrs)
          @attrs = attrs.instance_variable_get('@myhash')
        end

        def to_h
          attrs.each_with_object({}) {|(k,v),h|
            h[self.class.attributes[k]] = v.size > 1 ? v : v.first
          }
        end

        private

        def self.attributes
          {dn: :dn}
        end

        def self.base
          [prefix, ENV['LDAP_BASE']].join(',')
        end

        def self.directory
          @directory ||= Net::LDAP.new(
            host: ENV['LDAP_HOST'],
            port: ENV['LDAP_PORT'],
            encryption: :start_tls)
        end
      end
    end
  end
end