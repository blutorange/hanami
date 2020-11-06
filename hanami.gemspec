# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanami/version'

Gem::Specification.new do |spec|
  spec.name          = "hanami"
  spec.version       = Hanami::VERSION
  spec.authors       = ["Andre Wachsmuth"]
  spec.email         = ['sensenmann5@gmail.com']
  spec.description   = %q{Combines the functionality of the Mojinizer and Mecab gems. And adds merging of morphemes into what could be considered Japanese words.}
  spec.summary       = %q{A gem for converting from Japanese text with Kanji to kana or romaji, and adding spaces and hyphens between words.}
  spec.homepage      = "https://github.com/blutorange/hanami"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  ['ipadic-utf8', 'unidic-utf8', 'juman-utf8'].each do |dicdir|
    spec.files << "dic/#{dicdir}"
    ['AUTHORS','char.bin','COPYING','dicrc','matrix.bin','sys.dic','unk.dic','version'].each do |dicfile|
      file = "dic/#{dicdir}/#{dicfile}"
      if !File.exists?(file)
        puts "Make sure you extract the dictionary files in ./dic/dic.tar.gz first!"
        exit
      end
      spec.files << "dic/#{dicdir}/#{dicfile}"
    end
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(tests|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "moji", "~> 1.6"
  spec.add_runtime_dependency "mecab", "~> 0.996", '>= 0.996'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 13.0', '>= 13.0.0'
  spec.add_development_dependency "rspec", '~> 2.13', '>= 2.13.0'
end
