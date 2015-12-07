$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_events/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_events"
  s.version     = RailsEvents::VERSION
  s.authors     = ["Danny Burt"]
  s.email       = ["burtdaniel@gmail.com"]
  s.homepage    = "http://www.Dbz.rocks"
  s.summary     = "Creates a backbone events hash for your webapp"
  s.description = "Add Backbone style events without using the whole framework. This will provide a bare bones micro front-end framework for developing multi-page Rails applications with Javascript or CoffeeScript. This will increase the speed of all event based development, creation of dynamic content, and will add clear organization to Javascript/Coffeescript files. See <a href='https://github.com/Dbz/rails_events'>https://github.com/Dbz/rails_events</a> for more information"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "underscore-rails", ">= 1.0.0"
  s.add_dependency "underscore-string-rails", ">= 1.0.0"
  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "jquery-rails", ">= 1.0.0"
end
