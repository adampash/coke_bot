class TextToTweet
  attr_accessor :file

  def initialize(file_path)
    @file = File.new file_path
  end

  def self.get_tweets(text)
    tweets = []
    tweet = ""
    text.split(" ").each do |word|
      if tweet.length < 140
        tweet += "#{word} "
      else
        tweets << tweet
        tweet = "#{word} "
      end
      puts tweet
    end
    tweets << tweet
    tweets
  end

  def self.kill_bum_breaks(file)
    text = file.read.scrub
    text.gsub(/(?<!\n)\n(?!\n)/, ' ')
  end

  def self.get_sentences(text)
    text.chomp.split(/(?<=[?!.])/).map(&:strip)
  end

  def self.split_long_into_words(sentences)
    words = []
    sentences.each do |sentence|
      if sentence.length > 140
        words.push(sentence.split(" "))
      else
        words.push sentence
      end
    end
    words.flatten
  end

  def self.split_long_by_punct(sentences)
    new_sentences = []
    sentences.each do |sentence|
      if sentence.length > 140
        split = sentence.split(/(?<=[,;:])/)
        new_sentences.push(split).flatten!
      else
        new_sentences.push sentence
      end
    end
    new_sentences
  end

  def self.combine_sentences(sentences)
    new_sentences = []
    old_sentences = sentences
    index = 0
    until old_sentences[index+1].nil?
      # old_sentence = old_sentences.delete_at(index)
      new_sentence = "#{old_sentences[index]} #{old_sentences[index+1]}"
      if new_sentence.length < 140
        old_sentences.delete_at(index)
        old_sentences[index] = new_sentence
        new_sentences[index] = new_sentence
      else
        new_sentences[index] = old_sentences[index]
        index += 1
      end
    end
    new_sentences[index] = old_sentences[index]
    new_sentences
  end

end
