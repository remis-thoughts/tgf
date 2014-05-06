Gem::Specification.new do |s|
  s.name        = 'tgf'
  s.version     = '1.1.0'
  s.summary     = 'Trivial Graph Format (TGF)'
  s.description = 'A gem for parsing & writing Trivial Graph Format files or strings'
  s.author      = 'Remis'
  s.email       = 'remis.thoughts@gmail.com'
  s.files       = ['lib/tgf.rb', '.gemtest', 'Rakefile']
  s.test_files  = ['test/test_tgf.rb']
  s.homepage    = 'https://github.com/remis-thoughts/tgf'
  s.license     = 'Apache-2.0'

  s.add_development_dependency 'rake', '~> 0.9'
end

