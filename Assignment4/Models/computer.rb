module Computer

  def makeMove(level, game, player)
    if (level == 1)
      return rand(7)
    else
      playNum = game.pTurn.index(player)

      #searches for open spot adjacent to previously placed and places next move adjacent
      for cols in 6..0
        for rows in 5..0
          if game.state.element(rows, cols).type == game.players[playNum]
            if game.state.element(rows+1, cols).type == 'empty' 
              return cols
            elsif game.state.element(rows, cols+1).type == 'empty' 
              return cols+1
            end
          end
        end
      end

      return rand(7) #base case
    end
  end
  
end
