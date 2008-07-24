require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'

NAME = "confiture"
GEM_VERSION = "0.0.1"
AUTHOR = "Jonas Nicklas"
EMAIL = "jonas.nicklas@gmail.com"
HOMEPAGE = "http://example.com"
SUMMARY = "A configuration generator for deploying applications"

spec = Gem::Specification.new do |s|
  s.name = NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('templater', '>= 0.1.1')
  s.add_dependency('mash', '>= 0.3.0')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec,bin}/**/*")
  s.bindir = "bin"
  s.executables = [NAME]
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin locally"
task :install => [:package] do
  sh %{#{sudo} gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION} --no-update-sources}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

namespace :jruby do

  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{sudo} jruby -S gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION}.gem --no-rdoc --no-ri}
  end

end
