# Joins morphemes, for dictionary ipadic.

module Hanami
    MERGERS_IPADIC = [
        { :type => :suffix, 4 => ["名詞", "サ変接続", "読仮名なし"]},
        { :type => :suffix, 4 => ['括弧閉']},
        { :type => :suffix, 4 => ['読点']},
        { :type => :suffix, 4 => ['句点']},
        { :type => :suffix, 4 => ['記号', '一般']},
        { :type => :suffix, 0 => 'ん'},
        { :type => :prefix, 4 => ['特殊・ダ','体言接続'], 0 => 'な', :add => ' '},
        { :type => :prefix, 4 => ['係助詞'], 3 => 'は', :add => ' '},
        { :type => :prefix, 4 => ['接続助詞'], 3 => 'ちゃ', :add => ' '},

        { :type => :suffix, 4 => ['名詞','非自立'], 3 => 'もの',  :add => ' '},
        { :type => :suffix, 4 => ['名詞','非自立'], 3 => 'こと', :add => ' '},
        { :type => :suffix, 4 => ['非自立'], 3 => 'の', :add => ' '},
        { :type => :suffix, 4 => ['特殊・デス'], :add => ' '},
        { :type => :suffix, 4 => ['特殊・ダ'], :add => ' '},
        { :type => :suffix, 4 => ['連用タ接続'], 3 => 'がる'},
        { :type => :suffix, 4 => ['接尾'], 3 => 'っぱなし'},
        { :type => :suffix, 4 => ['動詞'], 3 => 'っぱなす'},
        { :type => :suffix, 4 => ['助詞','並立助詞'], 3 => 'たり'},
        { :type => :suffix, 4 => ['助詞','並立助詞'], 3 => 'だり'},
        { :type => :suffix, 4 => ['接尾'], 3 => 'させる'},
        { :type => :suffix, 4 => ['接尾'], 3 => 'せる'},
        { :type => :suffix, 4 => ['接尾'], 3 => 'られる'},
        { :type => :suffix, 4 => ['接尾'], 3 => 'れる'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'て'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'で'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'ながら'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'つつ'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'ちゃ'},

        { :type => :suffix, 4 => ["助動詞"]},

        { :type => :suffix, 4 => ['非自立'], 3 => 'よい', :add => ' '},
        { :type => :suffix, 4 => ['非自立'], 3 => 'いい', :add => ' '},

        { :type => :suffix, 4 => ['非自立']},
        { :type => :suffix, 4 => ['接尾'], :add => '─'},

        { :type => :prefix, 4 => ["名詞", "サ変接続", "読仮名なし"]},
        { :type => :prefix, 4 => ['括弧開']},
        { :type => :prefix, 4 => ['仮定形']},
        { :type => :prefix, 4 => ['未然形']},
        { :type => :prefix, 4 => ['接頭詞'], :add => '─'},

        [{ 4 => ['特殊・ダ']}, { 4 => ['接続助詞'], 3 => 'けど'}],
        [{ 4 => ['記号','一般']}, { 4 => ['記号','一般']}],
        [{ 4 => ['格助詞']}, { 4 => ['係助詞']}],
    ]
end
