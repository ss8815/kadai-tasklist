class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase #フォームデータのemailを小文字化して取得
    password = params[:session][:password] #フォームデータのpassword取得
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new #sessions/new.html.erbを再表示
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private

  def login(email, password)
    @user = User.find_by(email: email) #入力フォームと同じアドレスを持つユーザを検索し@userへ代入
    if @user && @user.authenticate(password) #ユーザー確認、パス確認
      session[:user_id] = @user.id #ログイン状態が維持
      return true
    else
      return false
    end
  end
end
