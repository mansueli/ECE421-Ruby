require 'test/unit/assertions'

module Contracts
  include Test::Unit::Assertions
  
  def init_pre(game)
    assert game.is_a?(game), "invalid game initialized"
  end
  
  def invar
  end
  
  def makeMove_pre(maker, move, game)
    assert((maker.is_a?(player) || maker.is_a?(computer)), "invalid move maker")
    assert game.pTurn[game.currentTurn] == maker, "not your turn"
    assert game.state.column(move).include?(Disc.new()), "invalid move"
  end
  
  def makeMove_post(maker, row, col, game)
    assert game.state.element(row, col).type == game.players[game.currentTurn]
  end

end