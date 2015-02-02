require_relative '../../lib/tweeter'

describe Tweeter do
  before :each do
    @tweeter = Tweeter.new
  end
  it "initializes" do
    expect(@tweeter.client).to be_a Twitter::REST::Client
  end

  # it "posts an update" do
  #   tweet = @tweeter.update "I am sad"
  #   reply = @tweeter.reply "#MakeItHappy", tweet.id
  #   sleep 36
  #   require 'pry'; binding.pry
  # end

  it "goes nuts" do
    file = File.new "#{File.dirname(__FILE__)}/../../data/tweet_friendly.txt"
    line_num = 1
    file.each_line do |line|
      puts "tweeting line ##{line_num}"
      puts line
      tweet = @tweeter.update line
      sleep 5
      puts "reply to tweet #{tweet.id}"
      reply = @tweeter.reply "@MeinCoke #MakeItHappy", tweet
      puts "reply id is #{reply.id}"
      line_num += 1
      tweet = nil
      reply = nil
      sleep 31
    end
  end

end
