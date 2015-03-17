# Use alternate shoulda-style DSL for tests
module PryTestCase::Test
  class TestCase < Minitest::Spec
    class << self
      alias :setup :before
      alias :teardown :after
      alias :context :describe
      alias :should :it
    end
  end
end
