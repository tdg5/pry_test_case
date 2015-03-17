require "test_helper"

module PryTestCase::Test
  class PryTestCaseTest < TestCase
    Subject = PryTestCase

    context Subject.name do
      should "be defined" do
        msg = "Expected Subject to refer to a module of a different name"
        refute_equal "Subject", Subject.name, msg

        msg = "Could not find #{Subject.name} module"
        assert Object.const_defined?(Subject.name), msg
      end

      should "define a semantic version" do
        msg = "Could not find version constant!"
        assert Subject.const_defined?(:VERSION), msg

        assert_match(/\d+\.\d+\.\d+/, Subject.const_get(:VERSION))
      end
    end
  end
end
