# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "formtastic-bootstrap"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Bellantoni"]
  s.date = "2011-12-21"
  s.description = "Formtastic form builder to generate Twitter Bootstrap-friendly markup."
  s.email = "mjbellantoni@yahoo.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/mjbellantoni/formtastic-bootstrap"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Formtastic form builder to generate Twitter Bootstrap-friendly markup."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<formtastic>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, ["~> 3.1"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec_tag_matchers>, [">= 0"])
    else
      s.add_dependency(%q<formtastic>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.1"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec_tag_matchers>, [">= 0"])
    end
  else
    s.add_dependency(%q<formtastic>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.1"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec_tag_matchers>, [">= 0"])
  end
end
