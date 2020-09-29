class Master::TagsController < Master::Base

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tags = Tag.all
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.js { flash.now[:success] = "保存しました。" }
      else
        format.js
      end
    end
  end

  def destroy
    @tags = Tag.all
    @tag = Tag.new
    Tag.find(params[:id]).destroy
    flash.now[:warning] = "削除しました。"
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

end
