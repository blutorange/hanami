# encoding: utf-8

# See README for more info.
#
# TODO
# MERGERS does and probably always will need some fine-tuning.

require 'mecab'
require 'moji'

require_relative './mojinizer/mojinizer.rb'

require_relative './hanami/kanji_to_kana.rb'
require_relative './hanami/kana_to_romaji.rb'
require_relative './hanami/to_ascii.rb'
require_relative './hanami/to_phonetic.rb'

require_relative './hanami/tagger.rb'
require_relative './hanami/unihan.rb'

require_relative './hanami/tables_mergers_unidic.rb'
require_relative './hanami/tables_mergers_ipadic.rb'
require_relative './hanami/tables_mergers_juman.rb'
require_relative './hanami/tables_punctuation.rb'
require_relative './hanami/tables_misc.rb'
