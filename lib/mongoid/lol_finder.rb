module Mongoid
  module LolFinder
    extend ActiveSupport::Concern

    module ClassMethods
      def find_for(*fields)
        @find_for_fields = *fields
      end

      def search(query="")
        @find_for_fields.inject(scoped) do |relation, field|
          relation.or({field => /#{query}/i})
        end
      end
    end
  end
end
