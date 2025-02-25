require 'sinatra'
require 'slim'
require 'sqlite3'
require 'sinatra/reloader'
require 'bcrypt'

get("/explore") do

    db = SQLite3::Database.new("db/db.db")
    db.results_as_hash = true;
    @results = db.execute("SELECT * FROM recepies")
    slim(:explore)

end 

get("/create") do

    slim(:create)
    

end

get("/profile") do

    slim(:profile)
    

end
