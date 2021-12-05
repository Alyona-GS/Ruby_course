# The program fills the hash with a ordinal numbers of vowels

vowels = Hash.new
alphabet = ('a'..'z').to_a

alphabet.each { |char| vowels[char] = alphabet.index(char) if "aeiouy".include? (char) }