class HomesController < ApplicationController

  def top
    if end_user_signed_in?
      redirect_to mypage_path(current_end_user.id)
    end
  end
  
  def contact_us
  end
end
