class CommentsController < ApplicationController
  before_action :require_user

  def create
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment creation Sucessful"
      redirect_to todo_path(@todo)
    else
      flash[:danger] = "Comment was not Created"
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end