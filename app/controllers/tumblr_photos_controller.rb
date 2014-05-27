class TumblrPhotosController < ApplicationController
  def index
    tumblr_client = Tumblr::Client.new
    photos = tumblr_client.tagged("#{params[:tag]}").select{ |p| p['type'] == 'photo' }

    render json: photos
  end
end
