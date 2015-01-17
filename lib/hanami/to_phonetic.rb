# Scans for Japanese text and convert to phonetic representation (kana or romaji).
# Japanese text = substrings of Katakana + Hiragana +
#                 Chinese_Characters + Punctuation + Numbers
# Optional options:
#   dic: :unidic, :ipadic, or :juman, the dictionary to use with the morphological parser
#   mode: orthographic (ha,wo,he,ou) or :phonetic (wa,o,e,oo)
#   level: convert to :romaji (shachou) or :kana (シャチョウ)
#   vowels: :macron (ō) or :double (o), needs mode :phonetic to work properly
#   system: :hepburn (shachou) or :kunrei (syatyou)

module Hanami
    public
    def self.to_phonetic(str, opts={})
        # defaults
        opts[:mode] ||= :phonetic
        opts[:dic]  ||= :unidic
        opts[:level] ||= :romaji
        opts[:vowels] ||= :double
        opts[:system] ||= :hepburn
        japanese = /(.??)([[\u3001-\u30ff]|[\u31c0-\u9fff]|[[:punct:]]|[0-9]|[\uff10-\uff19]]+)(.??)/
        lines = str.lines.map do |line|
            line.gsub!(japanese) do |jp|
                kana = kanji_to_kana($2, opts[:mode], opts[:dic])
                sub = if opts[:level] == :romaji
                    kana_to_romaji(kana, opts[:vowels], opts[:system])
                elsif opts[:level] == :kana
                    kana.hira_to_kata
                end
                if $1 != ' ' && $1 != '　' && !$1.empty?
                    sub = $1 + ' ' + sub
                end
                if $3 != ' ' && $3 != '　' && !$1.empty?
                    sub << ' ' + $3
                end
                sub
            end
            if opts[:level] == :romaji
                line.zen_to_han
            else
                line
            end
        end
        return lines.join
    end

    # Aliases
    def self.to_romaji(a,b={})
        b[:level] = :romaji
        to_phonetic(a,b)
    end
    def self.to_kana(a,b={})
        b[:level] = :kana
        to_phonetic(a,b)
    end

end
