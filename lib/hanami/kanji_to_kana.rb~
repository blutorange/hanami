# Runs the morphological parser to split the Japanese text into morphemes;
# and joins some of these together (as defined in the <MERGERS> table) to get
# a visually more aesthetic result.
#
# See Hanami#to_phonetic for options <mode> and <dic>.

module Hanami
    private
    def self.kanji_to_kana(str, mode, dic)
        merger = case dic
        when :unidic
            MERGERS_UNIDIC
        when :ipadic
            MERGERS_IPADIC
        when :juman
            MERGERS_JUMAN
        end

        n = case mode
        when :orthographic
            2
        when :phonetic
            1
        end

        # morphological parse
        str.tr!('-','─')
        morphemes = parse_mecab(str,dic)

        # merge morphemes
        kana = []
        morphemes.each do |feature|
            if kana.last && m = mergable?(kana.last.last,feature,merger)
                feature[n] = m[1] + feature[n]
                kana.last << feature
            else
                kana << [feature]
            end
        end

        # convert to kana
        kana = kana.map{|k|k.map{|x|x[n]}.join}.join(' ')
        if mode == :phonetic
            kana.gsub!('ヲ','オ') 
        end

        return kana
    end
end
