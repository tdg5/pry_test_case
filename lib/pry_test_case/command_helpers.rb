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
  # @see #command_exec_direct
  def command_exec_cli(command_string, options = {})
    Pry.run_command(command_string, options)
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
  # @see #command_exec_cli
  def command_exec_direct(command_string, options = {})
    args = command_string.split(/\s+/)
    match = args.shift
    Pry.commands.run_command(options, match, *args)
  end
end
