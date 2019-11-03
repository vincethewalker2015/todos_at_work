class OwnersController < ApplicationController

    def index

    end

    def new
      @owner = Owner.new
    end

    def create
      @owner = Owner.new(owner_params)
      if @owner.save
        flash[:success] = "New Owner Created"
        redirect_to users_path
      else
        render 'new'
      end
    end

    def show

    end

    def edit

    end

    def update

    end

    private

    def owner_params
      params.require(:owner).permit (:name)
    end

end