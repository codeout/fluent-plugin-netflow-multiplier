# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-netflow-multiplier"
  spec.version       = "0.1.1"
  spec.authors       = ["Shintaro Kojima"]
  spec.email         = ["goodies@codeout.net"]

  spec.summary       = "Fluentd filter plugin to multiply sampled netflow counters by sampling rate."
  spec.description   = "Fluentd filter plugin to multiply sampled netflow counters by sampling rate. It finds counters and sampling rate field in each netflow and calculate into other counter fields."
  spec.homepage      = "https://github.com/codeout/fluent-plugin-netflow-multiplier"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd", ">= 0.12"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.0"
end
