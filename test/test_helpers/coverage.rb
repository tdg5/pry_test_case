require "simplecov"
require "coveralls"
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.root(File.expand_path("../..", __FILE__))
SimpleCov.start do
  add_filter "test"
end
