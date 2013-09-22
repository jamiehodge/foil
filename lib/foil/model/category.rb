require_relative 'base'

module Foil
  module Model
    class Category < Base
      plugin :rcte_tree
      plugin :static_cache
      many_to_many :files
    end
  end
end

