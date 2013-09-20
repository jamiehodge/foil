require_relative 'base'

module Foil
  module Model
    class Tags < Base
      many_to_many :files
    end
  end
end

