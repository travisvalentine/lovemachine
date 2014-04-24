class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: request.subdomain)
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
