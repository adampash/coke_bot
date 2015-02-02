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

  def self.split_long_by_middle(sentences)
    new_sentences = []
    sentences.each do |sentence|
      if sentence.length > 140
        new_sentences.push(sentence.split(" ")).flatten!
      else
        new_sentences.push sentence
      end
    end
    new_sentences
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
    # length = sentences.length
    sentences.each_with_index do |sentence, index|
      unless sentences[index+1].nil?
        if sentences[index].length + sentences[index+1].length < 140
          new_sentence = "#{sentences.delete_at index} #{sentences[index]}"
          new_sentences.push new_sentence
        else
          new_sentences.push sentence
        end
      end
    end
    new_sentences
    # return sentences if sentences[index+1].nil?
    # if sentences[index].length + sentences[index+1].length < 140
    #   sentences[index] = "#{sentences.delete_at index} #{sentences[index]}"
    #   combine_sentences(sentences, index)
    # else
    #   # puts 'shifting'
    #   # sentences[index] = sentences.shift
    #   combine_sentences(sentences, index + 1)
    # end
  end


end
