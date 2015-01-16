# Converts to strict ascii, ie. only the characters U+0000--U+007F.
#   add_unihan_info: replace Unihan characters with some info instead of ?,
#                    when available (Japanese ON/kun reading, meaning,
#                    or otherwise Mandarin reading)
#
# See Hanami#to_phonetic for the other options.

module Hanami
    public
    def self.to_ascii(str,opts={})
        if opts[:add_unihan_info].nil?
            opts[:add_unihan_info] = true
        end
        # do not allow macrons, and convert to romaji
        opts[:level] = :romaji
        opts[:vowels] = :double
        rom = to_phonetic(str,opts)
        # replace weird kanji with some meaningful info, if possible
        if opts[:add_unihan_info]
            read_unihan if UNIHAN_INFO.empty?
            rom.gsub!(/[\u31c0-\u9fff]/) do |x|
                cp = "U+#{x.codepoints.first.to_s(16).rjust(4,'0')}"
                cp.gsub!(/([a-f])/){$1.upcase}
                if info = UNIHAN_INFO[x.codepoints.first]
                    "{{#{cp}: #{info}}}"
                else
                    "{{#{cp}}}"
                end
            end
        end
        # replace all non-ascii
        rom.gsub(/[^\u0000-\u007f]/,'?')
    end
end
