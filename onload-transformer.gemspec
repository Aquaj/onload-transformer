$:.unshift File.expand_path("../lib", __FILE__)
require 'sprockets/onload_transformer/version'

Gem::Specification.new do |s|
  s.name = "onload-transformer"
  s.authors = ["Jérémie Bonal"]
  s.email = ["jeremie.bonal@gmail.com"]
  s.version = Sprockets::OnloadTransformer::VERSION
  s.summary = "A short extension of Sprockets to wrap vendor JS libs to wait on DOMContentLoaded"
  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.license = "MIT"

  s.add_dependency 'sprockets', '>= 2.0', '<= 4'
end
