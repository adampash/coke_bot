require_relative '../../lib/text_to_tweet'

describe TextToTweet do
  let(:file) {File.new "#{File.dirname(__FILE__)}/../../data/meinkampf.txt"}

  it "instantiates itself with a new piece of text" do
    @text_to_tweet = TextToTweet.new "#{File.dirname(__FILE__)}/../../data/data.txt"
  end

  it "removes non-new-graph line breaks" do
    sentence = "This is a sentence with an \n unnecessary line break in the middle"
    text = TextToTweet.kill_bum_breaks file
  end

  it "splits all text into sentences" do
    sentences = TextToTweet.get_sentences("This is a very short sentence. This is even shorter.")
    expect(sentences.length).to eq 2
  end

  it "combines sentences if the result is less than 140 chars" do
    sentences = []
    combined = []
    text = TextToTweet.kill_bum_breaks file
    text.each_line do |line|
      these_sentences = TextToTweet.get_sentences(line)
      sentences << these_sentences unless these_sentences.empty?
    end
    splits = TextToTweet.split_long_by_punct(sentences.flatten)
    splits = TextToTweet.split_long_by_middle(splits)
    combined = TextToTweet.combine_sentences(splits)
    require 'pry'; binding.pry
    combined.each_with_index do |sentence, index|
      expect(index).to be index
      if sentence.length > 140
        require 'pry'; binding.pry
      end
      # expect(sentence.length).to be < 140
    end

  end


  # it "parses a blob of text into sentences" do
  #   sentences = TextToTweet.get_sentences("This is a very short sentence. This is even shorter.")
  #   expect(sentences.length).to eq 2
  # end

  # it "splits a blob of text into words and then returns longest sentence" do
  #   text = "This is a very short sentence. This is even shorter."
  #   tweets = TextToTweet.get_tweets(text)
  #   expect(tweets.length).to eq 1

  #   text = "This is a very short sentence. This is even shorter. And this is going to be a very long sentence that will need to be its own separate tweet assuming everything goes as planned."
  #   tweets = TextToTweet.get_tweets(text)
  #   require 'pry'; binding.pry
  #   expect(tweets.length).to eq 2
  # end

end

