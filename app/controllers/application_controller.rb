class ApplicationController < ActionController::API
  def authenticate_user!
    # token = request.headers['Authorization']
    token = bearer_token
    @current_session = Session.find_by(token: token)

    if token && @current_session
      @current_user = @current_session.user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def bearer_token
    auth_header = request.headers['Authorization']
    if auth_header&.start_with?('Bearer ')
      auth_header.split(' ').last
    end
    
  end
  

  # Helper method to access the current user
  def current_user
    @current_user
  end
end
