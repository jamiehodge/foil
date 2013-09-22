require_relative 'base'

module Foil
  module Model
    class Utterance < Base
      many_to_one :discourse
      many_to_one :file
    end
  end
end

