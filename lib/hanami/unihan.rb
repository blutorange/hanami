# Read info only when required

module Hanami
    private
    UNIHAN_INFO = {}
    def self.read_unihan
        File.open("#{File.expand_path(File.dirname(__FILE__))}/../../unihan/Unihan_Info",'r') do |io|
            io.each_line do |line|
                line.chomp!
                line.strip!
                data = line.split("\t")
                next if line.empty?
                UNIHAN_INFO[data[0].to_i] = data[1]
            end
        end
    end
end
