class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @q = Post.all.order(created_at: :desc).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(5)
    @author = Author.find(1)
    @recent_posts = Post.all.find_newest_article
    @all_category = Post.pluck(:category).uniq
  end
  
  def index_from_category
    @category = params[:category]
    @posts = Post.where(category: params[:category])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @submit_name = '登録する'
  end

  # GET /posts/1/edit
  def edit
    @submit_name = '更新する'
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    
    @post.category = "未指定" if @post.category.length==0

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def destroy_from_category
    Post.where(category: params[:category]).destroy_all
    redirect_to posts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :category)
    end
end
