# Mixin providing methods for executing Pry commands in various contexts and
# environments.
module PryTestCase::CommandHelpers
  # Evaluates the given command string as the Pry CLI would evaluate it. Behaves
  # more like executing the given command in a live Pry session would. This
  # means that Pry will intercept some behaviors that may be valuable to your
  # tests. For more direct access to the results and errors of a command
  # execution, see {#command_exec_direct}.
  #
  # @param [String] command_string The command string to execute including any
  #   arguments that the command string might take.
  # @param [Hash] options Optional arguments for manipulating the command
  #   execution environment.
  # @option options [Binding] :target (TOPLEVEL_BINDING) The target Binding that the command should
  #   be executed in. Also aliased as *:context*.
  # @option options [Boolean] :show_output (true) Flag indicating whether or not the
  #   output of the command should be displayed.
  # @option options [IO] :output (Pry.config.output) The IO object that the
  #   output of the command should be written to. If *:show_output* is false,
  #   the given IO object will be ignored and a new StringIO object will be used
  #   instead.
  # @option options [Pry::CommandSet] :commands (Pry.config.commands) The
  #   command set that the generated Pry instance should be created with.
  # @return [Object] The result of the command execution. The exact value
  #   returned varies depending on the command.
  # @see #command_exec_direct
  def command_exec_cli(command_string, options = {})
    Pry.run_command(command_string, options)
    result = Pry.current[:pry_cmd_result]
    result && result.retval != Pry::Command::VOID_VALUE ? result.retval : result
  end

  # Evaluates the given command string and runs the command directly without
  # going through the Pry CLI eval cycle. Allows more direct access to errors
  # and other things the CLI can make hard to get direct access to. To execute a
  # command in an environment more similar to a live Pry session, see
  # {#command_exec_cli}.
  #
  # @param [String] command_string The command string to execute including any
  #   arguments that the command string might take.
  # @param [Hash] options Optional arguments for manipulating the command
  #   execution environment.
  # @option options [Binding] :target (TOPLEVEL_BINDING) The target Binding that the command should
  #   be executed in. Also aliased as *:context*.
  # @option options [IO] :output (Pry.config.output) The IO object that the
  #   output of the command should be written to.
  # @option options [Pry::CommandSet] :command_set (Pry.config.commands) The
  #   command set that should be passed to the specified command when it is
  #   initialized.
  # @option options [Pry] :pry_instance The Pry instance that should be passed
  #   to the specified command when it is initialized. By default a new Pry
  #   instance will be generated from the given options.
  # @return [Object] The result of the command execution. The exact value
  #   returned varies depending on the command.
  # @see #command_exec_cli
  def command_exec_direct(command_string, options = {})
    exec_options = {
      :target => TOPLEVEL_BINDING,
      :output => Pry.config.output,
      :command_set => Pry.config.commands,
    }.merge!(options)
    exec_options[:eval_string] = command_string
    exec_options[:pry_instance] ||= Pry.new({
      :target => exec_options[:target],
      :output => exec_options[:output],
      :commands => exec_options[:command_set],
    })
    args = command_string.split(/\s+/)
    match = args.shift
    Pry.commands.run_command(exec_options, match, *args)
  end
end
