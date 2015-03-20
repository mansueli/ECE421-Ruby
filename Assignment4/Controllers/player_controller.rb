require 'singleton'
class PlayerController
  include Singleton
  def intialize(game)
    @game = game
  end
  
  def makeMove(move)
    @game.makeMode(move)
  end
  
end