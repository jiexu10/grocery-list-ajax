require "sinatra"
require "pg"
require 'pry'
require 'json'

configure :development do
  set :db_config, { dbname: "grocery_list_development" }
end

configure :test do
  set :db_config, { dbname: "grocery_list_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

def all_groceries
  all = nil
  db_connection do |conn|
    all = conn.exec("SELECT id, name FROM groceries ORDER BY id")
  end
  all
end

def create_grocery(name)
  db_connection do |conn|
    sql_query = "INSERT INTO groceries (name) VALUES ($1)"
    conn.exec_params(sql_query, [name])
  end
end

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  @groceries = all_groceries
  erb :groceries
end

post "/groceries" do
  name = params[:name]
  create_grocery(name) unless name.strip.empty?
  redirect "/groceries"
end

post "/groceries.json" do
  content_type :json

  item_name = params[:name]
  if item_name
    create_grocery(item_name)
  end
  added_item = select_item_name(params[:name])
  added_item[0].to_json
end

#FOR BONUS CHALLENGE ADD CODE BELOW THIS COMMENT
def select_item_name(name)
  selected = nil
  db_connection do |conn|
    sql_query = %(SELECT id, name FROM groceries WHERE name = $1)
    data = [name]
    selected = conn.exec(sql_query, data)
  end
  selected
end

def delete_item(id)
  data = [id]
  db_connection do |conn|
    sql_query = %(DELETE FROM groceries WHERE id = $1)
    conn.exec_params(sql_query, data)
  end
end

delete "/groceries/:id" do
  delete_item(params[:id])
  redirect "/groceries"
end

delete "/groceries/jsdelete/:id" do
  # 200 OK, or 404 Not Found if id dne
  delete_item(params[:id])
  if params[:id].nil? || params[:id].strip.empty?
    status 404
  else
    delete_item(params[:id])
    status 204
  end
end
