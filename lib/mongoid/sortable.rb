require 'active_support/concern'

module Mongoid
  module Sortable
    extend ActiveSupport::Concern

    included do
      field :priority, :type => Integer

      before_create do
        self.priority = self.class.count + 1
      end
    end

    module ClassMethods
      def update_priority(id, priority)
        where(id: id).update(priority: priority)
      end
    end
  end
end