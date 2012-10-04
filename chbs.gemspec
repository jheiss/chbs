# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chbs/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Heiss"]
  gem.email         = ["jheiss@aput.net"]
  gem.description   = %q{Pick four random, common words and string them together to make a very
  strong but easy to remember password}
  gem.summary       = %q{http://xkcd.com/936/}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\).reject{ |f| f =~ %r{^data/} }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chbs"
  gem.require_paths = ["lib"]
  gem.version       = Chbs::VERSION

  gem.add_development_dependency('nokogiri')
end
