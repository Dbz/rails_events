$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_events/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_events"
  s.version     = RailsEvents::VERSION
  s.authors     = ["Danny Burt"]
  s.email       = ["daniel.burt@workday.com"]
  s.homepage    = "http://www.Dbz.rocks"
  s.summary     = "Creates a backbone events hash for your webapp"
  s.description = "Creates a backbone events hash for your webapp"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "underscore-rails", ">= 0.0.0"
  
  s.add_development_dependency "sqlite3"
end
