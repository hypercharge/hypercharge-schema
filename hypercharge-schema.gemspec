# coding: utf-8
lib = File.expand_path('../lib/ruby/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "hypercharge-schema"
  spec.version       = '1.24.0'
  spec.authors       = ["Luzifer Altenberg", "Jan Mentzel"]
  spec.email         = ["luzifer@atomgas.de", "jan@hypercharge.net"]
  spec.summary       = %q{hypercharge API requests json schema}
  spec.homepage      = "https://sankyu.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib/ruby/"]

  spec.add_runtime_dependency 'json-schema', '~>1.1.1'

  spec.add_development_dependency "bundler", "~>1.3"
  #spec.add_development_dependency 'autoparse', '~>0.3.3'
  spec.add_development_dependency "minitest", '~>5.0.4'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'turn'
  spec.add_development_dependency 'debugger'

end
