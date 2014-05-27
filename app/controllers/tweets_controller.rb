class TweetsController < ApplicationController

  def index
    @tweets = TWITTER_CLIENT.search("##{params[:tag]} -rt").take(50).collect do |tweet|
      {
        'text'     => tweet.text,
        'url'      => tweet.url.to_s,
        'user'     => tweet.user.screen_name,
        'user_pic' => tweet.user.profile_image_url
      }
    end

    render json: @tweets
  end

end