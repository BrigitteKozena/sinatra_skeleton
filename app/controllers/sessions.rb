
#Login Page
get '/sessions/new' do
  if session[:id]
    @user = User.find(session[:id])
    redirect "/users/#{@user.id}"
  else
    erb :'/sessions/new'
  end
end

#Login submission
post '/sessions' do
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    session.delete(:id)
    @error = "Please check your email address and password and try again."
    erb :'/sessions/new'
  end
end

# Logout
delete '/sessions/:id' do
  session[:id] = nil
  redirect '/sessions/new'
end
