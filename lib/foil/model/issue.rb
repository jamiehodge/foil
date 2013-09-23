require_relative 'base'

module Foil
  module Model
    class Issue < Base
      many_to_one :file
    end
  end
end

