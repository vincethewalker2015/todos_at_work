class TodosController < ApplicationController
  #before_action :set_todo, only: [:show, :edit, :update, :destroy]
  #before_action :require_user, except: [:index, :show]
  #before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.image.attach(params[:todo][:image])
    @todo.user = current_user
    if @todo.save
      flash[:success] = "Post Sucessfully Created"
      redirect_to todo_path(@todo)
    else
      flash.now[:danger] = "Nope.. Try that again"
      render 'new'
    end

  end

  def show
    @todo = Todo.find(params[:id])
    @comment = Comment.new
    @comments = @todo.comments
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:success] = "Todo was Updated"
      redirect_to todo_path(@todo)
    else
      render 'edit'
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    flash[:danger] = "Todo Deleted"
    redirect_to todos_path
  end

  private

	def todo_params
	  params.require(:todo).permit(:name, :description, :image, owner_ids: [])
  end

  def require_same_user
    if current_user != @todo.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own Todos"
      redirect_to todos_path
    end
  end

end
