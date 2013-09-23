require_relative 'entry'

module Foil
  module Model
    class Person < Entry
      class << self
        def authenticate(id, password)
          entry = directory.authenticate(id, password)
          new(entry.to_h) if entry
        end
      end

      attr_reader :name, :title, :organization,
        :department, :mail, :group_ids

      def initialize(attrs)
        super
        @name         = attrs.fetch(:name, '')
        @title        = attrs.fetch(:title, '')
        @organization = attrs.fetch(:organization, '')
        @department   = attrs.fetch(:department, '')
        @mail         = attrs.fetch(:mail, '')
        @group_ids    = Array attrs[:group_ids]
      end

      def admin?
        group_ids.any? {|id| id == ENV['ADMIN_GROUP'] }
      end
    end
  end
end