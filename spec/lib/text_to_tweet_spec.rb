require_relative '../../lib/text_to_tweet'
require_relative '../spec_helper'

describe TextToTweet do
  let(:file) {File.new "#{File.dirname(__FILE__)}/../../data/data.txt"}

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
    punc_splits = TextToTweet.split_long_by_punct(sentences.flatten)
    splits = TextToTweet.split_long_into_words(punc_splits)
    combined = TextToTweet.combine_sentences(splits)
    combined.each_with_index do |sentence, index|
      expect(index).to be index
      expect(sentence.length).to be <= 140
    end

    # File.open("tweet_friendly.txt", "w+") do |f|
    #   f.puts(combined)
    # end
  end

  it "combines array elements until the combination is > 140 chars" do
    a = ['hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend', 'hi', 'there', 'my', 'good', 'friend']
    combined = TextToTweet.combine_sentences(a)
    expect(combined.length).to eq 2
    combined.each do |sentence|
      expect(sentence.length).to be <= 140
    end
  end

  it "splits long sentences into an array of words", :focus => true do
    s = "this is a long sentence that is over 140 chars and therefor will be split into an array of words that is made up of every word in this sentence"
    a = TextToTweet.split_long_into_words([s])
    expect(a.length).to eq 30

    combined = TextToTweet.combine_sentences(a)
    expect(combined.length).to eq 2
    expect(combined.first.length).to be <= 140
  end

end

