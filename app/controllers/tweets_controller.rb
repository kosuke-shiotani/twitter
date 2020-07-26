class TweetsController < ApplicationController
  before_action :twitter_client, except: :new

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(create_params)
    redirect_to :root
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "key:uHfri0fnb85xUl4aetFZAxk11"
      config.consumer_secret = "51klDX7UIAW5AZZVYL8dKoqS9LjDZmwdQRrT8DLouD8ShtWXx6"
      config.access_token = "1105621333315018752-asggJVdKJUmy847AjeOx2Qe1U50OnV"
      config.access_token_secret = "vbG5ktNdnY8d8pQSYyjjh8HIAcHQTbyu6XnX35xre3Ogu"
    end  
  end
  
  def post
    tweet = Tweet.order('random()').first
    status = tweet.text
    media = open(tweet.image)
    @client.update_with_media(status, media)
    redirect_to :root
  end

  private
  def create_params
    params.require(:tweet).permit(:text, :image)
  end
  
end  
