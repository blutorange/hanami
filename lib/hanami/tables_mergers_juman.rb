# Joins morphemes, for dictionary juman.

module Hanami
    MERGERS_JUMAN = [
        { :type => :prefix, 4 => ['括弧始']},
        { :type => :suffix, 4 => ['括弧終']},

        { :type => :suffix, 4 => ['読点']},
        { :type => :suffix, 4 => ['句点']},
        { :type => :suffix, 4 => ['記号','特殊']},

        { :type => :suffix, 4 => ['接尾辞'], 3 => 'そうだ', :add => '─'},
        { :type => :suffix, 4 => ['助動詞'], 3 => 'だろう', :add => ' '},

        { :type => :prefix, 4 => ['仮定形']},
        { :type => :prefix, 4 => ['未然形']},


        [{ 4 => ['動詞','基本連用形']}, { 4 => ['動詞']}],
        [{ 4 => ['動詞','基本連用形']}, { 4 => ['動詞性接尾辞']}],
        [{ 4 => ['基本連用形']}, { 4 => ['形容詞性述語接尾辞']}],
        [{ 4 => ['タ系連用テ形'], :add => ' '}, { 4 => ['形容詞'], 3 => 'よい'}],
        [{ 4 => ['タ系連用テ形']}, { 4 => ['動詞性接尾辞']}],
        [{ 4 => ['タ系連用テ形']}, { 4 => ['形容詞']}],

        { :type => :prefix, 4 => ['ダ列基本連体形'], 0 => 'な'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'たい'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'がる'},
        { :type => :suffix, 4 => ['動詞'], 3 => 'っぱなす'},
        { :type => :suffix, 4 => ['ナ形容詞'], 3 => 'んだ'},
        { :type => :suffix, 4 => ['接尾辞','タ形'], 3 => 'う'},
        { :type => :suffix, 4 => ['助詞','並立助詞'], 3 => 'たり'},
        { :type => :suffix, 4 => ['助詞','並立助詞'], 3 => 'だり'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'させる'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'せる'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'られる'},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'れる'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'ながら'},
        { :type => :suffix, 4 => ['接続助詞'], 3 => 'つつ'},
        { :type => :suffix, 4 => ["助動詞"], 3 => 'のだ', :add => ' '},
        { :type => :suffix, 4 => ["助動詞"]},
        { :type => :suffix, 4 => ['接尾辞'], 3 => 'ます'},
        { :type => :suffix, 4 => ['非自立']},
        { :type => :suffix, 0 => 'ぁ'},
        { :type => :suffix, 0 => 'ぃ'},
        { :type => :suffix, 0 => 'ぇ'},
        { :type => :suffix, 0 => 'ぅ'},
        { :type => :suffix, 0 => 'ぉ'},
        { :type => :suffix, 4 => ['接尾'], :add => '─'},
        { :type => :suffix, 4 => ['接尾辞'], :add => '─'},

        { :type => :prefix, 4 => ['接頭詞'], :add => '─'},
        { :type => :prefix, 4 => ['接頭辞'], :add => '─'},

        [{ 4 => ['記号','特殊']}, { 4 => ['記号','特殊']}],
        [{ 4 => ['格助詞']}, { 4 => ['副助詞']}],
        [{ 4 => ['読仮名なし']}, { 4 => ['読仮名なし']}]
    ]
end
