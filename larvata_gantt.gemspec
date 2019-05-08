$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "larvata_gantt/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "larvata_gantt"
  spec.version     = LarvataGantt::VERSION
  spec.authors     = ["Frank Lam"]
  spec.email       = ["ryzingsun11@yahoo.com"]
  spec.homepage    = "https://github.com/FTLam11/larvata_gantt"
  spec.summary     = "Rails engine plugin for Gantt charts"
  spec.description = "Rails engine plugin for Gantt charts"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.2"
  spec.add_dependency "activerecord-import"

  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-rails"
end
