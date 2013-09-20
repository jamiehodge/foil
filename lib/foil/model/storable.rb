require_relative '../storage'

module Foil
  module Model
    module Storable

      module ClassMethods

        def storage
          Storage.new(ENV['STORAGE_PATH'])[table_name]
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
          self.class.storage
        end
      end

      def self.included(base)
        base.extend ClassMethods
        base.send :include, InstanceMethods
        base.plugin :dirty
      end
    end
  end
end

