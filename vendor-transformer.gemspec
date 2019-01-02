Gem::Specification.new do |s|
  s.name = "vendor-transformer"
  s.version = "0.0.1"
  s.date = DateTime.now
  s.summary = "A short extension of Sprockets to wrap vendor JS libs to wait on DOMContentLoaded"
  s.files = [
    "lib/sprockets/vendor-transformer.rb"
  ]
  s.require_paths = ["lib"]
end
