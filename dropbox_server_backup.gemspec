# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dropbox_server_backup"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roman Snitko"]
  s.date = "2012-03-22"
  s.description = "Backs up stuff from your server to your Dropbox account"
  s.email = "roman.snitko@gmail.com"
  s.executables = ["dropbox_server_backup"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/dropbox_server_backup.rb"
  ]
  s.homepage = "http://github.com/snitko/dropbox_server_backup"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Backs up stuff from your server to your Dropbox account"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dropbox-sdk>, [">= 0"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<dropbox-sdk>, [">= 0"])
      s.add_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<dropbox-sdk>, [">= 0"])
    s.add_dependency(%q<term-ansicolor>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

