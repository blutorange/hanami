# coding: utf-8
module Mojinizer

  def romaji_kunrei
    s = gsub(/./){|c|Kunrei::KANA_TO_ROM[c] || c}
    #---------------------------------------------------------
    s = s.gsub(/(k)([aiueo])(")/,'g\2').gsub(/(s)([aiueo])(")/,'z\2').gsub(/(t)([aiueo])(")/,'d\2')
    s = s.gsub(/(h)([aiueo])(")/,'b\2').gsub(/([h])([aiueo])(')/,'p\2').gsub(/u"/,'vu') # [半]濁点゛゜
    #---------------------------------------------------------
    s.gsub!(/\s(xtsu)?\s/,'xtu')                             # Remove spaces before/after hanging 'っ'
    #---------------------------------------------------------
    while s.gsub!(/(xtu)([ckgsztdhbpmyrwnv])/,'\2\2') do;end # ッカ-->xtuka-->kka
    #---------------------------------------------------------
    # Compound Phoneme Pattern Rollbacks
    # NB: Uses regex backrefs like "\1y\3" where \1 = 1st capture grp, y='y' and \3 = 3rd capture grp
    #---------------------------------------------------------
    s.gsub!(/( +x)(.*)/,'x\2')                               # Avoid hanging chisaii moji due to leading spaces
    s.gsub!(/(t)(ix)(y[aueo])/,'\1\3')                       # チョ-->tixyo-->tyo
    s.gsub!(/([kgszjtdnhfbpmr])(ixy)([auo])/,'\1y\3')        # キャ-->kixya-->kya
    s.gsub!(/([kgszjtdnhfbpmr])(ix)([ie])/,'\1\3')           # キィ-->kixi-->kyi
    #---------------------------------------------------------
    s.gsub!(/([td])(exy)([aueo])/,'\1y\3')                   # テャ-->texya-->tya
    s.gsub!(/([td])(ex)([ie])/,'\1\3')                       # ティ-->texi-->ti
    s.gsub!(/([td])(oxu)/,'\1u')                             # ドゥ-->toxu-->tu
    s.gsub!(/(tu)(x)([aiueo])/,'t\3')                        # ツァ-->tuxa-->ta
    s.gsub!(/([td])(oxy)(u)/,'\1y\3')                        # ドュ-->doxyu-->dyu
    #---------------------------------------------------------
    s.gsub!(/(vux)([aieo])/ ,'v\2')                          # ヴァヴィヴェヴォ, ヴァ-->vuxa-->va
    s.gsub!(/(vuxy)([aueo])/ ,'vy\2')                        # ヴュ-->vuxyu-->vyu
    s.gsub!(/(ixe)/ ,'ie')                                   # イェ-->ixe-->ie
    s.gsub!(/(hoxe)/ ,'hoe')                                 # ホェ-->hoxe-->hoe
    s.gsub!(/(hux)([aieo])/ ,'h\2')                          # ファフィフェフォ, ファ-->huxa-->ha
    s.gsub!(/(huxy)([aueo])/,'hy\2')                         # フュ-->huxyu-->hyu
    s.gsub!(/(ux)([ieo])/, 'w\2')                            # ウァウィウェ, ウァ-->uxa-->wa
    #---------------------------------------------------------
    s.strip!                                                 # Recombine hanging 'っ'
    s.gsub!(/(xtu)$/,'h!')                                   # followed by EOL
    s.gsub!(/([aiueo]?)(\-)/, '\1\1')                        # Replace boubiki chars and double preceding vowel
    #--------------------------------------------------------- 
    while s.gsub!(/x([aiueo])x([aiueo])/,'\1\2') do;end      # ぁぁ-->xaxa-->aa
    while s.gsub!(/([aiueo])x([aiueo])/,'\1\2') do;end       # かぁ-->axa-->aa
    #---------------------------------------------------------
    # Cleanup specifically for source strings that contain spaces!
    s.gsub!(/( +)([^a-z|A-z])/, '\2')                        # Remove spaces before any non-alphabetical char
    s.gsub!(/(n')/,'n')                                      # ン-->nn-->n
    s.gsub!(/(nn)/,'n')                                      # ン-->nn-->n
    s.gsub!(/( n)[^a-z|A-Z]?$/,'n')                          # Fix "n" appearing as separate words
    s.gsub!(/\s{2,}/, ' ')                                   # Remove duplicate spaces!
    #---------------------------------------------------------
    return s
  end

  def romaji_hepburn
    s = gsub(/./) do |c|
      Hepburn::KANA_TO_ROM[c] || c
    end

    s=s.gsub(/(k)([aiueo])(")/,'g\2').gsub(/(s)([aiueo])(")/,'z\2').gsub(/(t)([aiueo])(")/,'d\2')
    s=s.gsub(/(h)([aiueo])(")/,'b\2').gsub(/([fh])([aiueo])(')/,'p\2').gsub(/u"/,'vu') # [半]濁点゛゜
    #---------------------------------------------------------
    s=s.gsub(/\s(xtsu)?\s/,'xtsu')                            # Remove spaces before/after hanging 'っ'
    #---------------------------------------------------------
    sw=s;
    while nil!=sw.gsub!(/(xtsu)([ckgszjtdhfbpmyrwnv])/,'\2\2') do; s=sw; end # ッカ-->xtsuka-->kka
    #---------------------------------------------------------
    # Compound Phoneme Pattern Rollbacks
    # NB: Uses regex backrefs like "\1y\3" where \1 = 1st capture grp, y='y' and \3 = 3rd capture grp
    #---------------------------------------------------------
    s=s.gsub(/( +x)(.*)/,'x\2')                               # Avoid hanging chisaii moji due to leading spaces
    s=s.gsub(/(ch)(ixy)([aueo])/,'\1\3')                      # チョ-->chixyo-->cho
    s=s.gsub(/([kgszjtdnhfbpmr])(ixy)([auo])/,'\1y\3')        # キャ-->kixya-->kya
    s=s.gsub(/([kgszjtdnhfbpmr])(ix)([ie])/,'\1y\3')          # キィ-->kixi-->kyi
    #---------------------------------------------------------
    s=s.gsub(/(sh)(y)([aueo])/,'\1\3')                        # シュ-->shyu-->shu
    s=s.gsub(/(j)(y)([aueo])/,'\1\3')                         # ジュ-->jyu-->ju
    #---------------------------------------------------------
    s=s.gsub(/([td])(exy)([aueo])/,'\1h\3')                   # テャ-->texya-->tha
    s=s.gsub(/([td])(ex)([ie])/,'\1\3')                       # ティ-->texi-->ti
    s=s.gsub(/([td])(oxu)/,'\1oo')                            # ドゥ-->toxu-->too
    s=s.gsub(/(tsu)(x)([aiueo])/,'ts\3')                      # ツァ-->tsuxa-->tsa
    s=s.gsub(/([td])(oxy)(u)/,'\1oy\3')                           # ドュ-->doxyu-->doyu
    #---------------------------------------------------------
    s=s.gsub(/(vux)([aieo])/ ,'v\2')                          # ヴァヴィヴェヴォ, ヴァ-->vuxa-->va
    s=s.gsub(/(vuxy)([aueo])/ ,'vy\2')                        # ヴュ-->vuxyu-->vyu
    s=s.gsub(/(ixe)/ ,'iye')                                  # イェ-->ixe-->iye
    s=s.gsub(/(hoxe)/ ,'howe')                                # ホェ-->hoxe-->howe
    s=s.gsub(/(fux)([aieo])/ ,'f\2')                          # ファフィフェフォ, ファ-->fuxa-->fa
    s=s.gsub(/(fuxy)([aueo])/,'fy\2')                         # フュ-->fuxyu-->fyu
    s=s.gsub(/(ux)([ieo])/, 'w\2')                            # ウァウィウェ, ウァ-->uxa-->wa
    #---------------------------------------------------------
    s=s.strip.gsub(/(xtsu)$/,'h!')                            # Recombine hanging 'っ' followed by EOL
    s=s.gsub(/([aiueo]?)(\-)/, '\1\1')                        # Replace boubiki chars and double preceding vowel
    #---------------------------------------------------------
    while s.gsub!(/x([aiueo])x([aiueo])/,'\1\2') do;end       # ぁぁ-->xaxa-->aa
    while s.gsub!(/([aiueo])x([aiueo])/,'\1\2') do;end        # かぁ-->axa-->aa
    #---------------------------------------------------------
    # Cleanup specifically for source strings that contain spaces!
    s=s.gsub(/( +)([^a-z|A-z])/, '\2')                        # Remove spaces before any non-alphabetical char
    s=s.gsub(/(n')/,'n')                                      # ン-->nn-->n
    s=s.gsub(/(nn)/,'n')                                      # ン-->nn-->n
    s=s.gsub(/( n)[^a-z|A-Z]?$/,'n')                          # Fix "n" appearing as separate word
    s=s.gsub(/\s{2,}/, ' ')                                   # Remove duplicate spaces!
    #---------------------------------------------------------
    return s
  end

  alias :romaji :romaji_hepburn

  def hiragana
    self.roma_to_kata.kata_to_hira
  end

  def katakana
    self.hira_to_kata.roma_to_kata
  end

  def hira_to_kata
    Moji.hira_to_kata(self)
  end

  def kata_to_hira
    Moji.kata_to_hira(self)
  end

  def han_to_zen
    Moji.han_to_zen(self)
  end

  def zen_to_han
    Moji.zen_to_han(self)
  end

  def normalize_zen_han
    Moji.normalize_zen_han(self)
  end

  def roma_to_kata

    result=""
    word_buffer=[]
    chars=self.each_char.collect{|c| c}
    loop do
      case word_buffer.size
        ##### When 0 characters in the buffer
      when 0 then
        if chars.size > 0
          word_buffer.push(chars.shift)
        else
          return result
        end
        ##### Patterns with 1 roman character
      when 1 then
        if word_buffer[0] =~ /[aiueo-]/
          result += ROM_TO_KATA1[word_buffer[0]]
          word_buffer = [] # a-->ア
        elsif word_buffer[0] =~ /[xkcgszjtdnhbpvfmyrlw']/
          if chars.size > 0
            word_buffer.push(chars.shift)
          else
            return result + (word_buffer[0].gsub(/n/,"ン"))
          end
        else
          result += word_buffer.shift
        end
        ##### Patterns with 2 roman characters
      when 2 then
        if ROM_TO_KATA2.key?(word_buffer.join)
          result += ROM_TO_KATA2[word_buffer.join]
          word_buffer = []
        elsif word_buffer.join =~ /([kgszjtcdnhbpmrl]y)|([stcd]h)|ts|(x[wytk])/ # goto 3
          if chars.size > 0
            # Consume next letter from source array
            word_buffer.push(chars.shift)
          else
            return result + (word_buffer.join.gsub(/n/,"ン"))
          end
        elsif word_buffer.join == "n'"
          result += "ン"
          word_buffer.shift(2) # n'--> ン
        elsif word_buffer[0] == "n"
          result += "ン"
          word_buffer.shift # nk-->ンk
        elsif word_buffer[0] == word_buffer[1]
          result += "ッ"
          word_buffer.shift # kk-->ッk
        else
          result += word_buffer.shift;
        end
        ##### Patterns with 3 roman characters
      when 3 then
        if ROM_TO_KATA3.key?(word_buffer.join)
          result += ROM_TO_KATA3[word_buffer.join]
          word_buffer=[]
        elsif word_buffer[0] == "n"
          result += "ン"
          word_buffer.shift
        else
          result += word_buffer.shift
        end
      end
    end
  end
end
