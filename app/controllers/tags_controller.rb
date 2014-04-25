class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: request.subdomain)
    @twitter = TWITTER_CLIENT.search("##{@tag.name} -rt", ).collect do |tweet|
      {
        text: tweet.text,
        url:  tweet.url.to_s,
        user: tweet.user.screen_name,
        user_pic: tweet.user.profile_image_url
      }
    end
    # tumblr_client = Tumblr::Client.new
    # @tumbler = tumblr_client.tagged("#{@tag.name}").select{ |p| p['type'] == 'photo' }
  end

  def index
    @tags = if current_user && current_user.tags.any?
      current_user.tags
    else
      Tag.all
    end
  end

  def create
    if @tag = Tag.where(name: params[:tag][:name]).first_or_create
      redirect_to root_url(subdomain: @tag.name)
    end
  end
end
