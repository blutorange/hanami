# Converts kana to romaji (mostly ascii).
# See Hanami#to_phonetic for options.
#
#   U+3000 -- U+303F is Japanese punctuation
#   U+3040 -- U+309F is hiragana, U+30A0 -- U+30FF is the katakana block
#   U+31C0 -- U+9FFF is are CJK blocks (Chinese characters, kanji)
 
module Hanami
    private

    def self.kana_to_romaji(str, long_vowels = :double, system = :hepburn)
        str = str.normalize_zen_han.kata_to_hira
        # replace now unused kana bigram
        str.gsub!('くゎ','kwa')
        # kana -> ascii
        str.gsub!(/([^\u30fc]+)/) do |text|
            text.gsub(/([\u3001-\u30ff]+)/) do |kana|
                if system == :hepburn
                    kana.romaji_hepburn
                else
                    kana.romaji_kunrei
                end
            end
        end
        # replace long vowels: "a─"  --> "aa" / "ā"
        str.gsub!(/([aiueo])\u30fc/) do
            LONG_VOWELS[long_vowels][$1]
        end
        # replace full-width punctuation
        str.gsub!(/./) do |marker|
            PUNCTUATION[marker] || marker
        end
        str.tr!('─','-')
        return str
    end
end
