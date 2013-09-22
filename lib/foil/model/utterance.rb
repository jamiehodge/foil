require_relative 'base'

module Foil
  module Model
    class Utterance < Base
      plugin :rcte_tree
      many_to_one :discourse
      many_to_one :file
    end
  end
end

