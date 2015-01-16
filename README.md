# You can cross-check with some algorhythms available on the net:
#
# https://translate.google.com/m/translate (shows romaji below the Japanese)
# http://nihongo.j-talk.com/ (from the options, choose "Spaced" and "Romaji")
#
# Keep in mind Japanese isn't written with ascii officially, and as such, there
# are no hard rules, especially how to place spaces. This implementation should
# provide should provide something that isn't too hard too read.
#
#
#
#
# Transliterates Japanese. Which is (almost) as hard as translating it.
# Ie, it can be done only approximately without a real life human.
#
# Transliterating Japanese by replacing each character individually is
# impossible. Consider the following Japanese sentences, all containing the
# character 生:
#
#   生まれた子供たち。
#   生きる意味を見失う。
#   生意気な小僧。
#   生える毛は、どうして長いの？
#   生糸がヨーロッパに輸出するようになった。
#   生活に困る。
#   生涯教育のために。
#   芝生のお手入れ。
#
# And now consider (one possible) transliteration:
#
#   umareta kodomo─tachi.
#   ikiru imi o miushinau.
#   namaiki na kozoo.
#   haeru ke wa, dooshite nagai no?
#   kiito ga yooroppa ni yushutsu suruyoo ni natta.
#   seikatsu ni komaru.
#   shoogai kyooiku no tame ni.
#   shibafu no o─teire.
#
# Take a close look. The character 生 (life, to be born, fresh) is 
# transliterated as either "u", "i", "nama", "ha", "ki", "sei", "shou", or "fu"
# depending upon the context. Additionally, note that Japanese hasn't got any
# spaces, but some spaces need to be introduces when transliterating.
#
# However, Japanese does have a syllabary (one glyph for each syllable). These
# are easy to transliterate into ascii on an (almost) 1:1 basis.
#
# Thus, transliteration involves a full-blown morphological analysis, and can
# be divided into three steps.
#
# (a) Parse the Japanese sentence into morphemes (for spaces) and their
#     kana (syllabary) readings (pronunciation). For example, 生まれた子供たち
#     would be turned into "うま,れ,た,こども,たち".
#     There are some free morphological analyzers available, some of them
#     written in/for ruby.
#
# (b) Take the morphemes produced by (a) and merge some of them, especially
#     those that can't occur in isolation. For example, "うま,れ,た" should be
#     merged to "うまれた". To illustrate, it's like writing "it end ed" instead
#     of "it ended". "-ed" is a morpheme, but it should be merged with "end".
#     There are no strict conventions here, so this involves some amount of
#     creativity.
#
# (c) Romanize (=ascii-fy) the kana. This is pretty straigh-forward, and can
#     be done almost with a simple mapping table. There are some combinations
#     of kana that should be transliterated differently, but at any rate, this
#     is the easiest parts and there are several libaries doing this.
#     Note that there are several romanization systems in use, so "こうこう"
#     could be written "koukou", "kookoo", "kōkō", or some rarer variations
#     such as "cȏcȏ".
#
# The code below is an attempt to illustrate how this might be done.


#
# Dictionary files are provided in "./dic" for convenience. It might be hard
# to track down the right version of the dictionaries in UTF-8.
#
#
# Gem <mojinizer> converts kana (Japanese syllabary "alphabet")
# into ascii ("romaji"). Mojinizer uses a rather phonetic approach.
# https://github.com/ikayzo/mojinizer
#
#
# Gem <mecab> needs the mecab binary, see:
# http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html
#
#
# TODO
#   Add better support for number/counters...
