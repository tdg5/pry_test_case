guard(:minitest, :all_after_pass => false, :all_on_start => false) do
  watch(%r{^lib/pry_test_case/(.+)\.rb$}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^(lib/pry_test_case|test/test_helper)\.rb$}) { "test" }
end
