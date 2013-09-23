require_relative '../db'
require_relative 'listenable'
require_relative 'searchable'
require_relative 'storable'

module Foil
  module Model
    Base = Class.new(Sequel::Model)

    class Base
      extend Listenable, Searchable

      attr_accessor :storage

      self.raise_on_save_failure = false
      self.raise_on_typecast_failure = false

      plugin :auto_validations, not_null: :presence
      plugin :optimistic_locking
      plugin :string_stripper
    end
  end
end

