# Simple cli for debugging.

require_relative './hanami.rb'

if caller.empty?
    if (0..7).include?(ARGV.length) && !['-h', '--help'].include?(ARGV[0])
        mode = (ARGV.shift || 'phonetic').downcase.to_sym
        dic = (ARGV.shift || 'unidic').downcase.to_sym
        level = (ARGV.shift || 'romaji').downcase.to_sym
        vowels = (ARGV.shift || 'double').downcase.to_sym
        system = (ARGV.shift || 'hepburn').downcase.to_sym
        pure_ascii = (ARGV.shift || '').downcase.to_s == 'ascii'
        add_unihan_info = (ARGV.shift || '').downcase.to_s == 'info'
        if ![:orthographic,:phonetic].include?(mode)
            $stderr.puts "invalid mode: #{mode}"
        elsif ![:juman,:ipadic,:unidic].include?(dic)
            $stderr.puts "invalid dictionary: #{dic}"
        elsif ![:romaji,:kana].include?(level)
            $stderr.puts "invalid level: #{level}"
        elsif ![:double,:macron].include?(vowels)
            $stderr.puts "invalid mode for long vowels: #{level}"
        elsif ![:kunrei,:hepburn].include?(system)
            $stderr.puts "invalid system: #{system}"
        else
            if mode == :orthographic && dic == :unidic
                $stderr.puts "mode #{mode} not supported by dictionary #{dic}"
            elsif mode == :phonetic && dic == :juman
                $stderr.puts "mode #{mode} not supported by dictionary #{dic}"
            elsif vowels == :macron && dic == :juman
                $stderr.puts "vowel mode #{vowels} not supported by dictionary #{dic}"
            else
                if vowels == :macron && mode == :orthographic
                    $stderr.puts "warning: mode #{mode} makes little sense with vowel mode #{vowels}"
                end
                text = $stdin.read.encode(Encoding::UTF_8)
                if pure_ascii
                    $stdout.puts Hanami.to_ascii(text,
                                                   :mode => mode,
                                                   :dic => dic,
                                                   :level => level,
                                                   :vowels => vowels,
                                                   :system => system,
                                                   :add_unihan_info => add_unihan_info)
                else
                    $stdout.puts Hanami.to_phonetic(text,
                                                      :mode => mode,
                                                      :dic => dic,
                                                      :level => level,
                                                      :vowels => vowels,
                                                      :system => system)
                end
            end
        end
    else
        puts "usage: ruby #{$0} [Phonetic|orthographic] [Unidic|juman|ipadic] [Romaji|kana] [Double|macron] [Hepburn|kunrei] [ascii [info]]"
        puts " - reads Japanese text from STDIN"
        puts " - outputs Ascii text to STDOUT"
    end
end
