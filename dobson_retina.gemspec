$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dobson_retina/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dobson_retina"
  s.version     = DobsonRetina::VERSION
  s.authors     = ["dobson engineering"]
  s.email       = ["gems@dobson.io"]
  s.homepage    = "http://retina.dobson.io"
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "dimensions", "~> 1.3.0"
  
end
