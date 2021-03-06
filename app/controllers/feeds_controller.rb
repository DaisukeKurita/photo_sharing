class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy ]
  before_action :login_only_operation, only: %i[ edit update destroy ]

  # GET /feeds or /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1 or /feeds/1.json
  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds or /feeds.json
  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        FeedMailer.feed_mail(@feed).deliver
        format.html { redirect_to @feed, notice: "投稿ができました" }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: "編集しました" }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "削除しました" }
      format.json { head :no_content }
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end
  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end
  def login_only_operation
    redirect_to feeds_path unless @feed.user == current_user
  end
end
