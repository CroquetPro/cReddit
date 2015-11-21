class SubsController < ApplicationController

    before_action :require_current_user!, only: [:new]
    before_action :require_moderator!, only: [:edit, :destroy]

    def new
      @sub = Sub.new
    end

    def show
      @sub = Sub.find(params[:id])
    end

    def create
      @sub = Sub.new(sub_params)
      if @sub.save
        flash[:notice] = ["Successfully created #{@sub.title}."]
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :new
      end
    end

    def edit
      @sub = Sub.find(params[:id])
      render :edit
    end

    def update
      @sub = Sub.find(params[:id])
      if @sub.update(sub_params)
        flash[:notice] = ["Successfully edited #{@sub.title}."]
        redirect_to sub_url(@sub)
      else
        @sub = Sub.new(sub_params)
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    end

    def destroy
      @sub = Sub.find(params[:id])
      if @sub.destroy
        flash[:notice] = ["Something beautiful died. Goodbye #{@sub.title}."]
        redirect_to subs_url
      else
        flash[:errors] = @sub.errors.full_messages
        redirect_to sub_url(@sub)
      end
    end

    def sub_params
      params.require(:sub).permit(:title, :description)
    end

    private
    def require_moderator!
      if current_user.id != self.moderator_id
        flash[:notice] = ['Must be moderator to edit this sub']
        redirect_to subs_url
      end
    end
end
