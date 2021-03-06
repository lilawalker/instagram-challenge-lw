class CommentsController < ApplicationController
  before_action :set_picture
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @picture, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @picture }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @picture, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @picture, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :picture_id)
  end

  def set_picture
    @picture = Picture.find(params[:picture_id])
  end

end
