class IdeasController < ApplicationController
	before_action :current_resource, only: [:show, :edit, :update, :destroy, :vote]

  # Search is using this right now
  def index
    @ideas = Idea.text_search(params[:query]).page(params[:page]).per_page(9)
  end

  def show
    if request.path != idea_path(@idea)
      redirect_to @idea, status: :moved_permanently
    end

    # The sidebar needs a board to pull up other ideas from (3 random ones).
    if @idea.board.ideas && @idea.board.ideas.count >= 3
      @rand_ideas = []
      3.times do
        @rand_ideas << @idea.board.ideas.sample
      end
    end

    @comments = @idea.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@idea, nil, "")
  end

  def new
    if Board.where(user_id: current_user).count == 0
      redirect_to new_user_board_path(current_user), notice: "Please create a board first."
    else
      @idea = Idea.new
      @boards = current_user.boards
      store_location
    end
  end

  def create
    process_video

    @idea = Idea.new(idea_params)
    if @idea.save
      redirect_to @idea, notice: "Idea was created."
    else
      @boards = current_user.boards
      render :new
    end
  end

  def edit
    @boards = current_user.boards
    store_location
  end

  def update
    process_video
    if @idea.update_attributes(idea_params)
      redirect_to @idea, notice: "Idea was updated."
    else
      @boards = current_user.boards
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to [@idea.user, @idea.board], notice: "Idea was deleted."
  end

  def vote
    @idea.votes += 1
    @idea.save
    redirect_to @idea
  end

  private

  	def current_resource
  		@idea = Idea.friendly.find(params[:id]) if params[:id]
  	end

    def idea_params
      params.require(:idea).permit(:title, :content, :votes, 
        :image, :image_cache, :video_url, :remote_image_url, :board_id)
    end

    def process_video
      video_url = params[:video_url]
      if video_url.present?
        if /vimeo/.match(video_url)
          params[:video_type] = "vimeo"
        end
      end
    end
end
