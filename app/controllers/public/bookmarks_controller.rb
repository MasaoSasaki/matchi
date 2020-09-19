class Public::BookmarksController < Public::Base

  before_action :authenticate_public_user!
    before_action :authenticate_public_user!, except: %i[top about contact privacy terms admin redirect new]


  def index
  end

  def show
  end

end
