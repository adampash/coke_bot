require 'twitter'
require 'yaml'
SECRETS = YAML::load(IO.read('config/secrets.yml'))

class Tweeter
  attr_accessor :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = SECRETS["twitter"]["consumer_key"]
      config.consumer_secret     = SECRETS["twitter"]["consumer_secret"]
      config.access_token        = SECRETS["twitter"]["access_token"]
      config.access_token_secret = SECRETS["twitter"]["access_token_secret"]
    end
  end

  def update(text)
    @client.update text
  end

  def reply(text, tweet)
    @client.update(text, {:in_reply_to_status => tweet})
  end

end
