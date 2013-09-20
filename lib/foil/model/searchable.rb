module Foil
  module Model
    module Searchable

      def searchable(default_columns)
        def_dataset_method(:search) do |query, columns = default_columns|
          return self if query.blank?

          full_text_search(Array(columns), Query.new(query).to_s)
        end
      end

      private

      class Query

        def initialize(query)
          @query = query
        end

        def to_s
          terms.map {|term| '%s:*' % term }
        end

        private

        def terms
          @query.split
        end
      end
    end
  end
end

