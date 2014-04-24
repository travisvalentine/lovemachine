class UserTagsController < ApplicationController
  def create
    user_tag = current_user.user_tags.new(tag_id: params[:id])
    if user_tag.save
      redirect_to root_url(subdomain: false)
    end
  end

  def destroy
    user_tag = current_user.user_tags.where(tag_id: params[:id]).first
    if user_tag.destroy
      redirect_to root_url(subdomain: false)
    end
  end
end
