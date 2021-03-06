class PostsController < BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  include ApplicationHelper

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10).order(created_at: 'desc')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params) do |post|
      post.user_id = current_user.id
    end

    respond_to do |format|
      if @post.save
        # format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js
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
      format.js { render status: 200, js: "toastr.info('Deleted')" }
    end
  end

  def like
    @post.liked_by current_user, vote_scope: 'post_like'
    @post.create_activity :like, owner: current_user, recipient: @post.user

    broadcast_to_recipient(@post, @post.user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  def unlike
    @post.unliked_by current_user, vote_scope: 'post_like'
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:content, :user_id, attachments: [])
  end

  def broadcast_to_recipient(post, recipient)
    ActionCable.server.broadcast("notification_for_user_#{recipient.id}",
                                 sender_name: recipient.name,
                                 time_sent_at: formatted_time(Time.now),
                                 id: post.id,
                                 type: 'Like',
                                 url_path: '/posts/' + post.id.to_s)
  end
end
