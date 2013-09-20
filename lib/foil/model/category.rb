require_relative 'base'

module Foil
  module Model
    class Category < Base
      plugin :rcte_tree
      many_to_many :files
    end
  end
end

