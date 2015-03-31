require 'test/unit/assertions'

module ClientContracts
  include Test::Unit::Assertions
  
  def create_game_pre(game)
    assert game.is_a?(game), "invalid game initialized"
  end

  def create_game_post()
    #message has been sent to server
  end
  
  def invar
  end
  
  def makeMove_pre(maker, move, game)
    assert((maker.is_a?(player) || maker.is_a?(computer)), "invalid move maker")
    assert game.pTurn[game.currentTurn] == maker, "not your turn"
    assert game.state.column(move).include?(Disc.new()), "invalid move"
  end
  
  def makeMove_post(maker, row, col, game)
    assert game.state.element(row, col).type == game.players[pTurn.index(maker)]
    assert game.pTurn[game.currentTurn] != maker, "still your turn"
    #message has been sent to server
  end

  def recvMove_pre(me, game)
    assert game.pTurn[game.currentTurn] != me, "still your turn"
  end

  def recvMove_post(me, game)
    assert game.pTurn[game.currentTurn] == me, "not your turn"
    #message received from server
  end
end