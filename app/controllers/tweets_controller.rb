class TweetsController < ApplicationController
  def index
    @tweets = TWITTER_CLIENT.search("##{params[:tag]} -rt", ).collect do |tweet|
      {
        'text'     => tweet.text,
        'url'      => tweet.url.to_s,
        'user'     => tweet.user.screen_name,
        'user_pic' => tweet.user.profile_image_url
      }
    end
    puts @tweets.to_json
    respond_to do |format|
      format.json {}
    end
  end
end
