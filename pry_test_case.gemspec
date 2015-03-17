# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pry_test_case/version"

Gem::Specification.new do |spec|
  spec.name          = "pry_test_case"
  spec.version       = PryTestCase::VERSION
  spec.authors       = ["Danny Guinther"]
  spec.email         = ["dannyguinther@gmail.com"]
  spec.summary       = "Library for testing Pry commands and extensions."
  spec.description   = <<-DESC
                       Library providing a test case class and other helpers for
                       testing Pry commands and extensions.
                       DESC
  spec.homepage      = "https://github.com/tdg5/pry_test_case"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "> 0"
  spec.add_development_dependency "pry", "> 0"
end
