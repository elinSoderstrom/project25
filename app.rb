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
    redirect('/create')
end

post("/user") do
    user= params["user"]
    pwd= params["pwd"]
    pwd_confirm= params["pwd_confirm"]
    db = SQLite3::Database.new("db/db.db")
    db.execute("SELECT id FROM users WHERE
    user=?",user)
    if result.empty?
        if pwd==pwd_confirm
            pwd_digest=BCrypt::Password
            .create(pwd)
            db.execute("INSERT INTO users(user,
            pwd_digest) VALUES(?,?)",user,pwd_digest)
            redirect("/explore")
        else
            redirect("/error") #Lösenord matchar ej
        end
    
    else
        redirect("/login") #User existerar redan
        end
        
    end
end

post("/login") do
    user = params["user"]
    pwd = params["pwd"]
    db = SQLite3::Database.new("db/db.db")
    result=db.execute("SELECT id,pwd_digest FROM
    users WHERE user=?",user)
    if result.empty?
        redirect("/error") #Fel lösenord/användarnamn
    end
    user_id = result.first["id"]
    pwd_digest = result.first["pwd_digest"]
    if BCrypt::Password.new(pwd_digest) == pwd
        session[:user_id] = user_id
        redirect("/welcome")
    else
        redirect("/error") #Fel lösenord/username
    end
end
