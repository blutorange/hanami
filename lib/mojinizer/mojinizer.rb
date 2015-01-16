require "moji"
require_relative "./version"
require_relative "./romaji_tables"
require_relative "./conversion"
require_relative "./detection"

class String
  include Mojinizer
end
