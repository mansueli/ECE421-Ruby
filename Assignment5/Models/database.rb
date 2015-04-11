# from lab 9
require 'mysql'

@db = Mysql.new("mysqlsrv.ece.ualberta.ca", "ece421usr3" , "a421Psn403", "ece421grp3", 13020)
# here is the API => http://www.rubydoc.info/gems/mysql/2.9.1/Mysql

# Unneccesary, put doing it for illustration purposes
#@db.select_db("ece421grp1")

@db.list_dbs
###=> ["information_schema", "ece421grp1"]

 @db.query("DROP TABLE IF EXISTS games")
   @db.query("CREATE TABLE games
              (
                game_id INT(10) AUTO_INCREMENT,
                game_type CHAR(40),
                player1 CHAR(40),
                player2 CHAR(40),
                lastplayer CHAR(40),
                lastmove INT(2),
                PRIMARY KEY (game_id)
              )
            ")
   rep = 'reptle'
=begin
   @db.query("INSERT INTO games (player1, player2, game_type, lastplayer)
                VALUES
                  ('#{rep}', 'frog', '4', 'lala'),
                  ('fish', 'racoon', 'otto', 'laala')
              ")
   puts "Number of rows inserted: #{@db.affected_rows}"

 @db.query("DROP TABLE IF EXISTS results")
   @db.query("CREATE TABLE results
              (
                game_id INT(10),
                result CHAR(40),
                FOREIGN KEY(game_id) REFERENCES games(game_id)
              )
            ")

game = nil
game_id = 1
res2 = @db.query("select lastplayer from games
  where game_id = '#{game_id}'")

res2.each_hash {|h| game =  h['lastplayer']}
#puts game_id
puts 'here'
puts game
=end

res = @db.query('describe games')

# gibberish producing, but if you try 'describe animal;' in mysql, you
# see what is going on
#
res.each {|l| puts l}

# Free up 'res' as an example
# puts "Before res.free -> Number of rows returned: #{res.num_rows}"

###res.free # free up res

# puts "After res.free -> Number of rows returned: #{res.num_rows}"
# The above prints a MySQL error not a ruby error - interesting

#  fetch_row and each return successive rows of the result, each row as
#  an array of column values. There are hashed versions of each
#  of these that return rows as hashes keyed by column
#  name. The hash method, fetch_hash is used like this:
res = @db.query('select * from animal')
res.each_hash {|h| puts h['name']}

#snake
#frog
#tuna
#racoon

puts "Number of rows returned: #{res.num_rows}"

#Finally, close the database
@db.close if @db