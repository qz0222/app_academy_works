class CommentsController < ApplicationController

  def index
    render :index
  end

  def new
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

end
