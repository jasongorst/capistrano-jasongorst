require_relative "lib/capistrano/jasongorst/version"

Gem::Specification.new do |spec|
  spec.name = "capistrano-jasongorst"
  spec.version = Capistrano::Jasongorst::VERSION
  spec.authors = ["Jason Gorst"]
  spec.email = ["jason.gorst@me.com"]

  spec.summary = "some useful capistrano tasks"
  spec.description = "A handful of capistrano tasks that I've found useful."
  spec.homepage = "https://github.com/jasongorst/capistrano-jasongorst"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jasongorst/capistrano-jasongorst.git"
  # spec.metadata["changelog_uri"] = "https://github.com/jasongorst/capistrano-jasongorst/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.18"
end
