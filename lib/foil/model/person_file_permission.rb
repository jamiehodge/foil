require_relative 'base'

module Foil
  module Model
    class PersonFilePermission < Base
      many_to_one :file
    end
  end
end

