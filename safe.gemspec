$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "safe/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "safe"
  s.version     = Safe::VERSION
  s.authors     = ["Kacper Cieśla"]
  s.email       = ["kacper.ciesla@gmail.com"]
  s.homepage    = "https://github.com/comboy/safe"
  s.summary     = "Keep readable logs from your multithreaded ruby scripts"
  s.description = s.summary

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
