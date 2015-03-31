class PlayerController
  attr_reader :game, :player

  def initialize(game, player)
    @game = game
    @player = player
  end

  def makeMove(move)
    @game.makeMove(move, @player)
  end

end
