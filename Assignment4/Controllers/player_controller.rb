class PlayerController
  def intialize(game, player)
    @game = game
    @player = player
  end

  def makeMove(move)
    @game.makeMove(move, @player)
  end

end
