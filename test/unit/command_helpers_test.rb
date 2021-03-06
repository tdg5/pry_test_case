require "test_helper"
require "pry_test_case/command_helpers"

module PryTestCase::Test
  class CommandHelpersTest < TestCase
    Subject = PryTestCase::CommandHelpers
    TestSubject = Class.new { include Subject }
    Pry.commands.create_command("command-with-return-value", :keep_retval => true) do
      def process
        args.first
      end
    end

    context Subject.name do
      subject { TestSubject.new }

      context "#command_exec_cli" do
        should "pass the given command and options directly to Pry.run_command" do
          command = "some-command"
          options = { :fake => :options }
          # Replicate bypassed side-effect
          (mock_result = mock).stubs(:retval).returns(true)
          Pry.current[:pry_cmd_result] = mock_result
          Pry.expects(:run_command).with(command, options)
          subject.command_exec_cli(command, options)
        end

        should "return the result of the command" do
          expected_value = "result"
          result = subject.command_exec_cli("command-with-return-value #{expected_value}", :show_output => false)
          assert_equal expected_value, result
        end
      end

      context "#command_exec_direct" do
        setup do
          @command = "some-command"
          @arg = "with_args"
          @command_with_arg = "#{@command} #{@arg}"
        end

        should "pass the given command and options to Pry.commands.run_command" do
          opts = {
            :target => "target",
            :output => "output",
            :command_set => "command_set",
            :pry_instance => "pry_instance",
          }
          expected_opts = opts.merge(:eval_string => @command_with_arg)
          Pry.commands.expects(:run_command).with(expected_opts, @command, @arg)
          subject.command_exec_direct(@command_with_arg, opts)
        end

        should "generate sane defaults for options not given" do
          expected_opts = {
            :command_set => Pry.config.commands,
            :eval_string => @command_with_arg,
            :output => Pry.config.output,
            :target => TOPLEVEL_BINDING,
          }
          pry_instance_opts = {
            :commands => expected_opts[:command_set],
            :output => expected_opts[:output],
            :target => expected_opts[:target],
          }
          pry_instance = Pry.new(pry_instance_opts.dup)
          Pry.expects(:new).with(pry_instance_opts).returns(pry_instance)
          expected_opts[:pry_instance] = pry_instance
          Pry.commands.expects(:run_command).with(expected_opts, @command, @arg)
          subject.command_exec_direct(@command_with_arg)
        end

        should "return the result of the command" do
          expected_value = "result"
          result = subject.command_exec_direct("command-with-return-value #{expected_value}", :output => StringIO.new)
          assert_equal expected_value, result
        end
      end
    end
  end
end
