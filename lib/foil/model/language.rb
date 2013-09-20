require_relative 'base'

module Foil
  module Model
    class Language < Base
      many_to_many :files
    end
  end
end

