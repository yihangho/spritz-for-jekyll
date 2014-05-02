Gem::Specification.new do |s|
  s.name                 = 'spritz_for_jekyll'
  s.version              = '1.0.0'
  s.date                 = '2014-05-02'
  s.summary              = 'Bringing Spritz to Jekyll'
  s.description          = 'A plugin for Jekyll that enables Spritz.'
  s.author               = 'Yihang Ho'
  s.email                = 'me@yihangho.com'
  s.homepage             = 'https://github.com/yihangho/spritz-for-jekyll'
  s.license              = 'MIT'
  s.files                = ['lib/spritz_for_jekyll.rb']

  s.add_development_dependency('jekyll', '~> 1.5.1')
  s.add_development_dependency('cucumber', '~> 1.3.14')
  s.add_development_dependency('rake', '~> 10.3.1')
end
