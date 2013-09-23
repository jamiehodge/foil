require_relative '../storage'

module Foil
  module Model
    module Storable

      module ClassMethods
        attr_writer :storage

        def storage
          @storage ||= Foil::Storage::Local.new(ENV['STORAGE_PATH'])
        end
      end

      module InstanceMethods
        def file
          @file ||= (storage[id] unless new?)
        end

        def file=(value)
          will_change_column :file
          @file = value
        end

        def after_create
          super
          storage[id] = file
        end

        def after_update
          super
          storage[id] = file if column_changed? :file
        end

        def after_destroy
          super
          storage.delete(id)
        end

        def storage
          self.class.storage[self.class.table_name]
        end
      end

      def self.included(base)
        base.extend         ClassMethods
        base.send :include, InstanceMethods

        base.plugin :dirty
      end
    end
  end
end

