class AuthorsController < ApplicationController
  def edit
    @author = params[:id]
  end

  def update
    author = Author.new
    author.updte(author_params)
    redirect_to posts_path
  end
  
  private
  
  def author_params
    params.require(:author).permit(:name, :description, :image_url)
  end
end
