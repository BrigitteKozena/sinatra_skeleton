#Create a new User AKA Signing Up
get '/users/new' do
  if session[:id]
    @user = User.find(session[:id])
    redirect "/users/#{@user.id}"
  else
    erb :'/users/new'
  end
end

#Submit New User to Database
post '/users' do
  @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
  @user.password = params[:password]
  if @user.save
    session[:id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :'/users/new'
  end
end

#Show all users/or users index page
get '/users' do
  erb :'/users/index'
end

#Edit User
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'/users/edit'
end

#Submit edited User
put '/users/:id' do
  @user = User.find(params[:id])
  @user.update(params[:user])
  redirect "/users/#{@user.id}"
end

#Show particular User
get '/users/:id' do
  @user = User.find(params[:id])
  if User.find(session[:id]) == @user
    erb :'/users/show' #private profile
  else
    erb :'/users/show' #public profile
  end
end

#Delete particular User
delete '/users/:id' do
  @user = User.find(params[:id])
  @user.destroy
  redirect "/logout"
end
