DATA = {}
File.open('./Unihan_Readings.txt','r') do |io|
    io.each_line do |line|
        line.chomp!
        line.strip!
        next if line.empty? || line[0] == '#'
        data = line.split("\t")
        cp = data[0].match(/U\+([0-9A-F]{4})/)
        if cp
            cp = cp[1].to_i(16)
            DATA[cp] ||= {}
            DATA[cp][data[1]] = data[2]
        end
    end
end

File.open('./Unihan_Info','w') do |io|
    DATA.each_pair do |key,val|
        info = []
        dft = val['kDefinition'].to_s
        dft.gsub!(/\(.*?[^\u0000-\u007f]+?.*?\)/,'')
        dft.gsub!(/([vV])ariant of [^\u0000-\u007f] (U\+[0-9A-F]{4})/,'\1ariant of \2')
        dft.gsub!(/([vV])ariant of (U\+[0-9A-F]{4}) [^\u0000-\u007f]/,'\1ariant of \2')
        dft.gsub!(/same as [^\u0000-\u007f] (U\+[0-9A-F]{4})/,'same as \1')
        dft.gsub!(/equivalent to [^\u0000-\u007f]+ (U\+[0-9A-F]{4})/,'equivalent to \1')
        dft.gsub!(/same as ([^\u0000-\u007f])/){"same as U+#{$1.codepoints.first.to_s(16).rjust(4,'0')}"}
        dft.gsub!(/used for (U\+[0-9A-F]{4}) [^\u0000-\u007f]/,'used for \1')
        dft.gsub!(/non-standard form of (U\+[0-9A-F]{4}) [^\u0000-\u007f]/,'non-standard form of \1')
        dft.gsub!(/non-standard form of [^\u0000-\u007f] (U\+[0-9A-F]{4})/,'non-standard form of \1')
        dft.gsub!(/ancient form of ([^\u0000-\u007f])/){"ancient form of U+#{$1.codepoints.first.to_s(16).rjust(4,'0')}"}
        dft.gsub!(/\(Cant.\) [^\u0000-\u007f]+,/,'(Cant.)')
        dft.gsub!(/\(Cant.\) [^\u0000-\u007f]+/,'(Cant.)')
        if dft.index(/[^\u0000-\u00ff]/)
            puts val['kDefinition']
            dft = $stdin.gets.chomp.strip
        end
        info << val['kJapaneseOn'].to_s.upcase
        info << val['kJapaneseKun'].to_s.downcase
        info << dft
        info << val['kMandarin'].to_s if info.empty?
        info.delete('')
        unless info.empty?
            io << key << "\t" << info.join('; ').squeeze(' ') << "\n"
        end
        if info.join('; ').squeeze(' ').index(/[^\u0000-\u00ff]/)
            puts "non-ascii found, aborting"            
            p val
            exit
        end
    end
end
