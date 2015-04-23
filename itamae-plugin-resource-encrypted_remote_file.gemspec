# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-encrypted_remote_file"
  spec.version       = "0.0.1.beta1"
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = "encrypt secret data, and forward decrypted file to remote."
  spec.description   = "encrypt secret data, and forward decrypted file to remote."
  spec.homepage      = "https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", "~> 1.2.13"
  spec.add_dependency "reversible_cryptography"

  spec.add_development_dependency "bundler", ">= 1.9.4"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
