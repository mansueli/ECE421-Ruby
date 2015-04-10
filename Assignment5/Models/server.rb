require "xmlrpc/server"

port = 50525


class MoveHandler
	def initialize
		@player = ''
		@move = -1
	end

	def makeMove(player, move)
		if @player != player
			@player = player
   			@move = move
		end
		#puts @move
		#puts @player   		
	end

   	def recvMove(player)
   		if @player == player
   			return @move
   		else
   			return -1
   		end
   	end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler('move',  MoveHandler.new)

server.serve