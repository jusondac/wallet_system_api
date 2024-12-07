class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      token = SecureRandom.hex(16) # Generate a secure random token
      session = Session.create!(user: user, token: token)

      render json: { token: token, message: 'Login successful!' }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # Logout endpoint
  def destroy
    session = Session.find_by(token: request.headers['Authorization'])

    if session
      session.destroy
      render json: { message: 'Logout successful!' }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end