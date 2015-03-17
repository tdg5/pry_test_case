require "test_helper"
require "pry_test_case/command_helpers"
require "pry"

module PryTestCase::Test
  class CommandHelpersTest < TestCase
    Subject = PryTestCase::CommandHelpers
    TestSubject = Class.new { include Subject }

    context Subject.name do
      subject { TestSubject.new }

      context "#eval_command" do
        should "lala" do
          binding.pry
        end
      end
    end
  end
end
