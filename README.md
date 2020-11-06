# Hanami

Overview
---------

Transliterates Japanese. Which is (almost) as hard as translating it.
Ie, it can be done only approximately without a real life human.

Fortunately, most of the hard work has already been done. This gem combines
[mecab](https://github.com/taku910/mecab), a morphological parser
with a slightly modified version of [mojinizer](https://github.com/ikayzo/mojinizer).

Mecab produces morphemes, this gem merges some of them into "words" - there is
no universal standard for what constitutes a word.

But examples are better than talking, so...

```ruby
require 'hanami'
japanese = '昨日洗濯しなくちゃいけなかった。'
japanese.encode(Encoding::UTF_8)
puts Hanami.to_romaji(japanese)
```

This results in:

> kinoo sentaku shinakucha ikenakatta.'

Which is way easier to read than the raw output of mecab, which looks like

> kinoo sentaku shi naku cha ike nakaxtsu ta.

In case you want to try it out yourself, there a simple command line script in
./lib/cli.rb

If you prefer "ou" instead of "oo":

```ruby
puts Hanami.to_romaji(japanese, :mode => :orthographic, :dic => :ipadic)
 => 'kinou sentaku shinakucha ikenakatta.'
```

And if you like macros (ō),

```ruby
puts Hanami.to_romaji(japanese, :vowels => :macron)
 => 'kinō sentaku shinakucha ikenakatta.'
```

Finally, if you're a fan on non-phonetic kunrei-style romanization:

```ruby
puts Hanami.to_romaji(japanese, :system => :kunrei)
 => 'kinoo sentaku sinakutya ikenakatta.'
```

I have included three dictionaries, as tracking down the right version in
UTF-8 might not be an easy job. They can be found ./lib, to save space they are
compressed, extract them first. Different dictionaries may provide different
results. The default is :unidic, which I think provides the best results overall.

```ruby
japanese = '茲に此迄の結果を標す。'
puts Hanami.to_romaji(japanese, :dic => :unidic)
  => 'koko ni kore made no kekka o shirusu.'
 puts Hanami.to_romaji(japanese, :dic => :ipadic)
  => '茲 ni 此迄 no kekka o shirusu.'
 puts Hanami.to_romaji(japanese, :dic => :juman)
  => '茲 ni 此迄 no kekka wo 標su.'
```

Speaking of which, if you ever need pure ascii:

```ruby
puts Hanami.to_ascii(japanese, :dic => :ipadic, :add_unihan_info => false)
  => '? ni ?? no kekka o shirusu.'
```

You can set :add_unihan_info to `true` to print some ascii info on those
characters instead:

```ruby
puts Hanami.to_ascii(japanese, :dic => :ipadic, :add_unihan_info => true)
  => '{{U+8332: JI SHI; shigeru masu mushiro; now, here; this; time, year}} ni {{U+6B64: SHI; koko kore kono; this, these; in this case, then}}{{U+8FC4: KITSU; oyobu made; extend, reach; until; till}} no kekka o shirusu.'
```

Installing & Links
------------------

Installing should be pretty straigh-forward. 

- Uncompress the dictionary files in ./dic/dic.tar.gz first.

- Build & install gem.

```bash
$ gem build hanami.gemspec
$ gem install hanami-0.0.2.gem
```

- Load gem with

```ruby
require 'hanami`
Hanami.to_romaji('日本語', :dic => :ipadic)
  => "nihongo"
```

Needs the <gem> mecab, which needs `mecab`, which can be found here:

https://github.com/taku910/mecab

There's also a ruby port available there, if you should encounter any problems
installing the <mecab> gem.

Also uses mojinizer, but all neccessary files are included as I had to modify it
slightly for kunrei romanization. The project can be found here:

https://github.com/ikayzo/mojinizer


Romanizing Japanese
-------------------

Transliterating Japanese by replacing each character individually is
impossible. Consider the following Japanese sentences, all containing the
character 生:

 -  生まれた子供たち。
 -  生きる意味を見失う。
 -  生意気な小僧。
 -  生える毛は、どうして長いの？
 -  生糸がヨーロッパに輸出するようになった。
 -  生活に困る。
 -  生涯教育のために。
 -  芝生のお手入れ。

And now consider (one possible) transliteration:

 - umareta kodomo─tachi.
 - ikiru imi o miushinau.
 - namaiki na kozoo.
 - haeru ke wa, dooshite nagai no?
 - kiito ga yooroppa ni yushutsu suruyoo ni natta.
 - seikatsu ni komaru.
 - shoogai kyooiku no tame ni.
 - shibafu no o─teire.

Take a close look. The character `生` (life, to be born, fresh) is 
transliterated as either "u", "i", "nama", "ha", "ki", "sei", "shou", or "fu"
depending upon the context. Additionally, note that Japanese hasn't got any
spaces, but some spaces need to be introduces when transliterating.


However, Japanese does have a syllabary (one glyph for each syllable). These
are easy to transliterate into ascii on an (almost) 1:1 basis.

Thus, transliteration involves a full-blown morphological analysis, and can
be divided into three steps.

(a) Parse the Japanese sentence into morphemes (for spaces) and their
    kana (syllabary) readings (pronunciation). For example, 生まれた子供たち
    would be turned into "うま,れ,た,こども,たち".
    There are some free morphological analyzers available, some of them
    written in/for ruby.

(b) Take the morphemes produced by (a) and merge some of them, especially
    those that can't occur in isolation. For example, "うま,れ,た" should be
    merged to "うまれた". To illustrate, it's like writing "it end ed" instead
    of "it ended". "-ed" is a morpheme, but it should be merged with "end".
    There are no strict conventions here, so this involves some amount of
    creativity.

(c) Romanize (=ascii-fy) the kana. This is pretty straigh-forward, and can
    be done almost with a simple mapping table. There are some combinations
    of kana that should be transliterated differently, but at any rate, this
    is the easiest parts and there are several libaries doing this.
    Note that there are several romanization systems in use, so "こうこう"
    could be written "koukou", "kookoo", "kōkō", or some rarer variations
    such as "cȏcȏ".


Cross-Checking
--------------
You can cross-check with some romanization algorithms/tools available on the net:

 - https://translate.google.com/m/translate (shows romaji below the Japanese)
 - http://nihongo.j-talk.com/ (from the options, choose "Spaced" and "Romaji")

He didn't release any info on this, but comparing the output from `Nihongo J-Talk` to `hanami`, I'm pretty sure he's doing pretty much the same as this program.

Keep in mind Japanese isn't written with ascii officially, and as such, there
are no hard rules, especially how to place spaces. This implementation should
provide should provide something that isn't too hard too read.

A quick example using this gem, and the above mentioned tools:

[Japanese sentence:](http://ja.wikipedia.org/w/index.php?title=%E8%8A%B1%E8%A6%8B)

> 前もって広い場所を占有する団体や、カラオケの使用や音楽を流したり、火気の使用、立小便、酔った勢いで桜の枝を折る、木を傷つけるなど、桜に悪影響を与えたり、他の花見客や近隣住民に対する迷惑行為を行う集団・団体が増え、大きな社会問題となっている。

Google translate:

> Maemotte hiroi basho o sen'yū suru dantai ya, karaoke no shiyō ya ongaku o nagashi tari, kaki no shiyō, tachishōben, yottaikioi de sakura no eda o oru, ki o kizutsukeru nado, sakura ni akueikyō o atae tari, hoka no hanami kyaku ya kinrin jūmin ni taisuru meiwaku kōi o okonau shūdan dantai ga fue, ōkina shakaimondai to natte iru.

Nihongo J-Talk:

> Maemotte hiroi basho o senyū suru dantai ya, karaoke no shiyō ya ongaku o nagashi tari, kaki no shiyō, tatsu shōben, yotta ikioi de sakura no eda o oru, ki o kizutsukeru nado, sakura ni akueikyō o atae tari, ta no hanami kyaku ya kinrin jūmin nitaisuru meiwaku kōi o okonau shūdan. dantai ga fue, ōkina shakai mondai to natte iru.

Hanami (with unidic):

> mae motte hiroi basho o senyuu suru dantai ya, karaoke no shiyoo ya ongaku o nagashitari, kaki no shiyoo, risshooben, yotta ikioi de sakura no eda o oru, ki o kizutsukeru nado, sakura ni aku-eekyoo o ataetari, ta no hanami kyaku ya kinrin juumin ni taisuru meewaku kooi o okonau shuudan.dantai ga fue, ookina shakai mondai to natteiru.

So I'd say, this gem doesn't fare to badly. 

Also, this is a good example why I'd say unidic is the best. Compare:

Juman:

> maemotte hiroi basho wo senyuu suru dantai ya, karaoke no shiyou ya ongaku wo nagashitari, kaki no shiyou, ta shouben, yotta ikioi de sakura no eda wo oru, ki wo kizutsukeru nado, sakura ni aku eikyou wo ataetari, tano hanami kyaku ya kinrin juumin ni taisuru meiwaku koui wo okonau shuudan° dantai ga fue, ookina shakai mondai to natteiru.

Ipadic:

> maemotte hiroi basho wo senyuu suru dantai ya, karaoke no shiyou ya ongaku wo nagashitari, kaki no shiyou, tatsu shouben, yotta ikioi de sakura no eda wo oru, ki wo kizutsukeru nado, sakura ni akueikyou wo ataetari, ta no hanami kyaku ya kinrin juumin nitaisuru meiwaku koui wo okonau shuudan° dantai ga fue, ookina shakai mondai to natteiru.

Note especially `立小便`.

TODO
----
 - Add better support for number/counters... But I'm not alone. Try `一頭` on Nihongo J-Talk, it gives `Ichi tō` as well.
 - Fine-tune <MERGERS> tables, used for merging morphemes into words.
