class TodosController < ApplicationController

	def index
	  @todos = Todo.all
	end

	def new
	  @todo = Todo.new
	end

	def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:success] = "Post Sucessfully Created"
      redirect_to todo_path(@todo)
    else
      render 'new'
    end
	end

	def show
    @todo = Todo.find(params[:id])
	end

	private

	def todo_params
	  params.require(:todo).permit(:name, :description)
	end

end