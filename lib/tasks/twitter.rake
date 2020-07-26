namespace :twitter do
  desc "random_tweet"
  task :tweet => :environment do
    twitter_client
    tweet = Tweet.order('random()').first
    status = tweet.text
    media = open(tweet.image)
    @client.update_with_media(status, media)
  end
end

def twitter_client
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = "自分のConsumer Key(API key)"
    config.consumer_secret = "自分のConsumer Secret(API secret)"
    config.access_token = "自分のAccess token"
    config.access_token_secret = "自分のAccess token secret"
  end
end