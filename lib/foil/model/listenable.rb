require 'json'

module Foil
  module Model
    module Listenable
      module ClassMethods

        def listen(callback, timeout: 5, &block)
          db.listen(table_name, loop: callback, timeout: timeout) do |channel, pid, payload|
            block.call(JSON.parse(payload)) if block
          end
        end
      end

      module InstanceMethods

        def listen(callback, timeout: 5, &block)
          db.listen(self.class.table_name, loop: callback, timeout: timeout) do |channel, pid, payload|
            data = JSON.parse(payload)
            block.call(data) if data['id'].to_i == id
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
        base.send :include, InstanceMethods
      end
    end
  end
end

