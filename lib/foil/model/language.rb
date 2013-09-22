require_relative 'base'

module Foil
  module Model
    class Language < Base
      plugin :static_cache
      many_to_many :files
    end
  end
end

