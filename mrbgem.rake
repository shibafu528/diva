require_relative 'lib/diva/version'

MRuby::Gem::Specification.new('mruby-diva') do |spec|
  spec.license     = 'MIT'
  spec.authors     = ['Toshiaki Asai', 'shibafu528']
  spec.version     = Diva::VERSION
  spec.summary     = %q{Implementation of expression for handling things.}

  spec.add_dependency 'mruby-metaprog', :core => 'mruby-metaprog'
  spec.add_dependency 'mruby-kernel-ext', :core => 'mruby-kernel-ext'
  spec.add_dependency 'mruby-time', :core => 'mruby-time'
  spec.add_dependency 'mruby-struct', :core => 'mruby-struct'
  spec.add_dependency 'mruby-secure-random', :github => 'monochromegane/mruby-secure-random'
  spec.add_dependency 'mruby-uri', :github => 'zzak/mruby-uri'
end
