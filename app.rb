require 'sinatra'
require 'slim'
require 'sqlite3'
require 'sinatra/reloader'
require 'becrypt'

get("/explore") do

    slim(:explore)
    db=

end 

get("/create") do

    slim(:create)
    db=

end

get("/profile") do

    slim(:profile)
    db=

end
