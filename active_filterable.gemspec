# frozen_string_literal: true

require_relative "lib/active_filterable/version"

Gem::Specification.new do |spec|
  spec.name = "active_filterable"
  spec.version = ActiveFilterable::VERSION
  spec.authors = ["Kervin"]
  spec.email = ["kervinchangyu@gmail.com"]

  spec.summary = "ActiveFilterable is a Ruby gem that provides custom query filters for ActiveRecord models through metaprogramming. It allows you to easily define custom filters based on the attributes and query methods of a model in Rails applications, simplifying the querying process."
  spec.description = "ActiveFilterable is a gem designed to enable custom query filters for ActiveRecord models through metaprogramming. By using ActiveFilterable, you can specify which attributes of a model can be used for filtering and define different query methods such as full-text matching, prefix matching, suffix matching, IN queries, NOT IN queries, equality, greater than, less than, not equal, greater than or equal to, and less than or equal to. ActiveFilterable provides a concise and flexible way to handle complex query requirements. It allows you to define query filters directly in the model and apply them by chaining method calls in the controller, generating the corresponding query conditions."
  spec.homepage = "https://github.com/kervinchang/active_filterable"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kervinchang/active_filterable"
  spec.metadata["changelog_uri"] = "https://github.com/kervinchang/active_filterable/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 5.0"
  spec.add_dependency "activesupport", ">= 5.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
