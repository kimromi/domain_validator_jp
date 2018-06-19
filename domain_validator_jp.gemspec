
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "domain_validator_jp/version"

Gem::Specification.new do |spec|
  spec.name          = "domain_validator_jp"
  spec.version       = DomainValidatorJp::VERSION
  spec.authors       = ["kimromi"]
  spec.email         = ["kimromi4@gmail.com"]

  spec.summary       = %q{domain name validator includes JP domain}
  spec.description   = %q{domain name validator includes JP domain}
  spec.homepage      = "https://github.com/kimromi/domain_validator_jp"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "public_suffix"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry-byebug"
end
