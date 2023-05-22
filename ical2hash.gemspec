# frozen_string_literal: true

require_relative 'lib/ical2hash/version'

Gem::Specification.new do |spec|
  spec.name = 'ical2hash'
  spec.version = Ical2hash::VERSION
  spec.authors = ['thehighhigh']
  spec.email = ['Yuto.ld.1017@gmail.com']

  spec.summary = 'It can convert ical txt to hash object and revert.'
  spec.description = 'It can convert ical txt to hash object and revert.'
  spec.homepage = 'https://github.com/thehighhigh/ical2hash'
  spec.required_ruby_version = '>= 2.6.0'
  spec.license = 'MIT'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/thehighhigh/ical2hash'
  spec.metadata['changelog_uri'] = 'https://github.com/thehighhigh/icar/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
