class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = comment.new(comment_params)
    if @comment.save
      flash[:success] = 'Comment was created succesfully'
      redirect_to comment_path(@comment)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Comment was successfully updated'
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:danger] = 'Comment was successfully deleted'
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end
