module Hanami
    # dictionary files included
    DICFILE = { :juman => "#{File.expand_path(File.dirname(__FILE__))}/../../dic/juman-utf8",
                :unidic => "#{File.expand_path(File.dirname(__FILE__))}/../../dic/unidic-utf8",
                :ipadic => "#{File.expand_path(File.dirname(__FILE__))}/../../dic/ipadic-utf8",
              }

    # double long vowels or use macrons
    LONG_VOWELS = {
        :double => {'a' => 'aa', 'i' => 'ii', 'u' => 'uu', 'e' => 'ee', 'o' => 'oo'},
        :macron => {'a' => 'ā', 'i' => 'ī', 'u' => 'ū', 'e' => 'ē', 'o' => 'ō'}
    }
end
