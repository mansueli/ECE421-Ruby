require "xmlrpc/server"
require 'mysql'

port = 50525


class MoveHandler
	def initialize
		@player = ''
		@move = -1
		@db = Mysql.new("mysqlsrv.ece.ualberta.ca", "ece421usr3" , "a421Psn403", "ece421grp3", 13020)
	end

	def createGame(player, type)
		begin
			#find first unstarted game
			res = @db.query("select game_id from games
				where player1 <> '#{player}' and player2 is null and game_type = '#{type}'")

			game_id = nil
			if res.num_rows > 0
				res.each_hash {|h| game_id = h['game_id']}
				@db.query("UPDATE games
	   				SET player2 = '#{player}'
	   				WHERE game_id = '#{game_id}'
	              ")
				turn = 0
			else
				@db.query("insert into games (game_type, player1, lastplayer)
					values ('#{type}', '#{player}', '#{player}')
	              ")
				res = @db.query("select game_id from games
					where player1 = '#{player}' and player2 is null and game_type = '#{type}'")
				res.each_hash {|h| game_id = h['game_id']}
				turn = 1
			end

			return game_id, turn

		rescue Mysql::Error => e
	    	return e.error
	    end
	end

	def makeMove(game_id, player, move)
		res = @db.query("select lastplayer from games
			where game_id = '#{game_id}'")

		lastplayer = nil
		res.each_hash {|h| lastplayer =  h['lastplayer']}

		if lastplayer != player
   			@db.query("UPDATE games
   				SET lastplayer = '#{player}', lastmove = '#{move}'
   				WHERE game_id = '#{game_id}'
              ")
   			return true
		end
		return false
		#puts @move
		#puts @player   		
	end

   	def recvMove(game_id)
		res = @db.query("select * from games
			where game_id = '#{game_id}'")

		lastmove = -1
		res.each_hash {|h| lastmove = h['lastmove']}

		return lastmove
   	end

   	def game_end(game_id)
   		res = @db.query("select result from results
				where game_id = '#{game_id}'")

   		result = -1
		if res.num_rows > 0
			res.each_hash {|h| result = h['result']}
		end
		return result
   	end

   	def game_over(game_id, status, player = '')
   		if status == 0 
   			@db.query("insert into results (game_id, result)
   				values ('#{game_id}', 'draw')
              ")
   		else
   			@db.query("insert into results (game_id, result)
   				values ('#{game_id}', #{player})
              ")
   		end
   	end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler('move',  MoveHandler.new)

server.serve