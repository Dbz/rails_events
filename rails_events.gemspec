$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_events/0.1"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_events"
  s.version     = RailsEvents::VERSION
  s.authors     = ["Danny Burt"]
  s.email       = ["daniel.burt@workday.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsEvents."
  s.description = "TODO: Description of RailsEvents."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "sqlite3"
end
