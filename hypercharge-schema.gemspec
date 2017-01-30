# coding: utf-8
lib = File.expand_path('../lib/ruby/', __FILE__)
require File.expand_path('hypercharge/schema/version.rb', lib)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "hypercharge-schema"
  spec.version       = Hypercharge::Schema::VERSION
  spec.authors       = ["Luzifer Altenberg", "Jan Mentzel"]
  spec.email         = ["luzifer@atomgas.de", "jan@hypercharge.net"]
  spec.summary       = %q{hypercharge API requests json schema}
  spec.homepage      = "https://sankyu.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib/ruby/"]

  spec.add_runtime_dependency 'json-schema', '~>2.7.0'

  spec.add_development_dependency "bundler", "~>1.3"
  spec.add_development_dependency "minitest", '>=4.7.5'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'rake'

end
