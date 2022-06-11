# frozen_string_literal: true

module Waylon
  # Update this to match the desired Waylon::Core::VERSION to release
  VERSION = "0.1.7"
end

Gem::Specification.new do |spec|
  spec.name          = "waylon"
  spec.version       = Waylon::VERSION
  spec.authors       = ["Jonathan Gnagy"]
  spec.email         = ["jonathan@therubyist.org"]

  spec.summary       = "Wrapper gem for the Waylon Bot Framework"
  spec.description   = "Wrapper gem to ease the installation of the Waylon Bot Framework"
  spec.homepage      = "https://github.com/jgnagy/waylon"
  spec.license       = "MIT"
  spec.required_ruby_version = "~> 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jgnagy/waylon"
  spec.metadata["changelog_uri"] = "https://github.com/jgnagy/waylon/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "waylon-core"

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "rubocop", "~> 1.23"
  spec.add_development_dependency "rubocop-rake", "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.6"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "yard", "~> 0.9", ">= 0.9.27"
end
