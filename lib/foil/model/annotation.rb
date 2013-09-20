require_relative 'base'

module Foil
  module Model
    class Annotation < Base
      many_to_one :discourse
      many_to_one :file
    end
  end
end

