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

post("/create") do

    name = params[:name]
    ingredients =params[:ingredients]
    instructions = params[:instructions]
    db = SQLite3::Database.new("db/db.db")
    db.execute("INSERT INTO recepies (name, ingredients, instructions) VALUES (?,?,?)", [name, ingredients, instructions])
    redirect('/create')
    
end

get("/profile") do

    slim(:profile)
    

end

get("/delete") do

    slim(:delete)
    
end

post("/delete") do

    id = params[:name]
    db = SQLite3::Database.new("db/db.db")
    db.execute("DELETE FROM recepies WHERE name = ?", id)
    redirect('/explore')
end

