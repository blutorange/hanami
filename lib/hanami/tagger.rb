# Calls mecab and parses the output.
module Hanami

    # Dictionary files get loaded dynamically when needed.
    TAGGERS = {}

    private

    # Load dictionary dynamically when needed.
    def self.get_tagger(dic)
        dicdir = DICFILE[dic]           
        TAGGERS[dic] ||= MeCab::Tagger.new ("--dicdir=#{dicdir}")
        return TAGGERS[dic]
    end

    # Morpheme <f> matches an entry <m> in MERGERS iff all features specified
    # in that entry are present in the morpheme.
    def self.match_merge?(f,m)
        m.keys.inject(true) do |s,k| s && 
            (k==:add || k==:type || 
              (
                (!m[0] || m[0]==f[0]) &&
                (!m[1] || m[1]==f[1]) &&
                (!m[2] || m[2]==f[2]) &&
                (!m[3] || m[3]==f[3]) &&
                (!m[4] || !m[4].any?{|x|!f[4].include?(x)})
              )
            )
        end
    end

    # Decides whether word <f> or <g> should be merged with the
    # previous / following word.
    # Lookup table ist <mergers>.
    def self.mergable?(f, g, mergers)
        # っ should never occur at a word boundary
        if f[2][-1] == 'ッ' || g[2][0] == 'ッ' || f[2][-1] == 'っ' || g[2][0] == 'っ'
            return true,''
        end
        val = mergers.find do |m|
            if m.class == Array
                match_merge?(f,m[0]) && match_merge?(g,m[1])
            elsif m[:type] == :prefix 
                match_merge?(f,m)
            else
                match_merge?(g,m)
            end
        end
        if val
            if val.class == Array
                return true, val[0][:add] || ''
            else
                return true, val[:add] || ''
            end
        else
            return false
        end
    end

    # Every dictionary <dic> returns a slightly different output format.
    # Takes a dictionary line (a morpheme) <str>, parses it and returns either
    # nil (invalid/EOS), or an array with the morpheme's info:
    # [SURFACE_FORM, PHONETIC_SPELLING, KANA_SPELLING, NORMALIZED_SPELLING, [TAGS]]
    def self.parse_dic(str,dic)
        case dic
        when :ipadic
            x = str.split("\t")
            if x[1]
                y = x[1].split(',')
                y.map!{|k| k=='*' ? nil : k}
                z = y.slice!(0..5)
                z.delete(nil)
                y[4] = z
                y[0], y[1], y[2], y[3] = x[0], y[2], y[1], y[0]
                y.slice(0..4)
            end
        when :unidic
            x = str.split("\t")
            if x[0] != "EOS"
                y1 = x[4].to_s.split('-')
                y2 = x[5].to_s.split('-')
                y3 = x[6].to_s.split('-')
                x.delete('')
                x[4] = y1.concat(y2).concat(y3)
                x[0], x[1], x[2], x[3] = x[0], x[1], x[1], x[3]
                x.slice(0..4)
            end
        when :juman
            x = str.split("\t")
            if x[1]
                y = x[1].split(',')
                y.map!{|k| k=='*' ? nil : k}
                z = y.slice!(0..3)
                z.concat(y[2].split(' ')) if y[2]
                z.delete(nil)
                y[4] = z
                y[0], y[1], y[2], y[3] = x[0], y[1], y[1], y[0]
                y.slice(0..4)
            end
        end
    end

    # Runs mecab with dictionary <dic> on an entire string <str>.
    # Sets the morpheme's surface form as the KANA, PHONETIC or NORMALIZED
    # SPELLING if those are not present; and add the TAG 読仮名なし in this case.
    def self.parse_mecab(str,dic)
        tagger = get_tagger(dic)
        morphemes = tagger.parse(str).split("\n").map do |line|
            next unless f = parse_dic(line,dic) # ignore EOS (end-of-line)
            add_tag = false
            (1..3).each do |i|
                if f[i].nil? || f[i].empty?
                    add_tag = true
                    f[i] = f[0]
                end
            end
            f[4] << '読仮名なし' if add_tag
            f
        end.compact
        return morphemes
    end

end
