lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fried/dependency/version"

Gem::Specification.new do |spec|
  spec.name          = "fried-dependency"
  spec.version       = Fried::Dependency::VERSION
  spec.authors       = ["Fire-Dragon-DoL"]
  spec.email         = ["francesco.belladonna@gmail.com"]

  spec.summary       = %q{Easily define object dependencies}
  spec.description   = %q{Easily define object dependencies and inject them}
  spec.homepage      = "https://github.com/Fire-Dragon-DoL/fried-dependency"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "fried-test"
  spec.add_development_dependency "fried-typings"

  spec.add_runtime_dependency "fried-core"
  spec.add_runtime_dependency "fried-call"
end
