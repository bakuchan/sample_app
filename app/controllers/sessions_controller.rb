class SessionsController < ApplicationController
  
  # get /login
  def new
    # scope: :session + url: login_path
  end
  
  # post /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Success
      # log_in(@user)
      log_in user
      redirect_to user
    else
      # Failure
      # alert-danger => 赤色のフラッシュ
      flash.now[:danger] = 'Invalid email/password combination' # flashはページが切り替わったら消える
      render 'new'
      # redirect_to vs. render
      # get /users/1 => show template
      #                 render 'new' (ページの切り替えが0回目)
    end
  end
  
  # DELET /logout
  def destroy
    log_out
    redirect_to root_url
  end
end
