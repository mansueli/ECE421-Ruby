require 'test/unit/assertions'

module ServerContracts
  include Test::Unit::Assertions

  def init_pre(port)
    assert port.is_a?(Fixnum) && port > 0, "Invalid Port"
  end

  def init_post
    #server is created
  end

  def new_game_pre(game)
    assert game.is_a?(game), "invalid game initialized"
    assert((game.players[0].is_a?(player) || maker.players[0].is_a?(computer)), "invalid player1")
    assert((game.players[1].is_a?(player) || maker.players[1].is_a?(computer)), "invalid player2")
    #assert game ID not found in database
  end

  def new_game_post()
    #game is created on server and ID is found in database
  end
  
  def invar
  end
  
  def makeMove_pre(maker, move, game)
    assert((maker.is_a?(player) || maker.is_a?(computer)), "invalid move maker")
    assert game.pTurn[game.currentTurn] == maker, "not your turn"
    assert game.state.column(move).include?(Disc.new()), "invalid move"
    assert game.isActive, "game has already ended"
    #assert game ID is found in database
  end
  
  def makeMove_post(maker, row, col, game)
    assert game.state.element(row, col).type == game.players[game.currentTurn]
    #game state change reflected server side
  end
  def game_over(game)
    #end the game specified on database
  end

  def isClientsResponsive?
    #@TODO verify if the client crashed and make give the win to the other player
  end
end