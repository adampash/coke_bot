require_relative '../../lib/tweeter'

describe Tweeter do
  before :each do
  end

  # it "posts an update" do
  #   tweet = @tweeter.update "I am sad"
  #   reply = @tweeter.reply "#MakeItHappy", tweet.id
  #   sleep 36
  #   require 'pry'; binding.pry
  # end

  it "goes nuts" do
    words = %w(oh wow omg interesting compelling uh-huh seriously! stop! no! fantasticmarvelous wonderful sensational outstanding superb super excellent first-rate! dazzling breathtaking fabulous wicked awesome brilliant extraordinary  unbelievable! remarkable impresssive phenomenal)
    file = File.new "#{File.dirname(__FILE__)}/../../data/tweet_friendly.txt"
    line_num = 1
    file.each_line do |line|
      puts "Instantiating new rest client"
      @tweeter = Tweeter.new
      sleep 3
      puts "tweeting line ##{line_num}"
      puts line
      tweet = @tweeter.update line
      sleep 5
      puts "reply to tweet #{tweet.id}"
      reply = @tweeter.reply "@MeinCoke #{words.sample} #MakeItHappy", tweet
      puts "reply id is #{reply.id}"
      puts "something went wrong" if reply.id == tweet.id
      line_num += 1
      tweet = nil
      reply = nil
      sleep 28
    end
  end

end
