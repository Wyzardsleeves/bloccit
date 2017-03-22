#define RandomData as a module because it is a standalone library with no dependencies
module RandomData
#defines random_paragraph. Sets senteces to an array.
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end
    sentences.join(" ")
  end #def self.random_paragraph
  #follows same partern as 6 to create a sentence with tweaks
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end
    sentence = strings.join(" ")
    sentence.capitalize << "."
  end #def self.random_sentence

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end #def self.random_word
end #module RandomData
