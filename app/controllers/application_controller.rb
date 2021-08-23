class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def verify_ownership(model)
    if model.user_id != current_user.id
      redirect_to model
    end
  end
end
