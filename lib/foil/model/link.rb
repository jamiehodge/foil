require_relative 'base'

module Foil
  module Model
    class Link < Base
      many_to_many :files
    end
  end
end

