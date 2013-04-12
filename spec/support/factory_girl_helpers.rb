module FactoryGirl
  module TestHelpers
    def should_have_a_valid_factory(name=nil)
      factory_name = name || subject.class.name.underscore

      FactoryGirl.build(factory_name).should be_valid
      FactoryGirl.create(factory_name).should be_persisted
    end
  end
end

