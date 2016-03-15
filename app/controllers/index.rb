get '/' do
  redirect '/sessions/new'
end


#checking if logged in
get '/secret' do
  redirect '/sessions/new' unless session[:id]
  "Secret area!"
end
