require '../Models/disc.rb'
require '../Models/computer.rb'
require '../Views/game_view.rb'
require 'singleton'
require 'observer'
require 'matrix'

class Game
  include Singleton
  include Observable
  include Computer
  attr_accessor :type, :state, :currentTurn, :pTurn
  attr_reader :players

  def newGame(type, gview, p1, p2)
    @pTurn = [p1, p2]
    if type == 'otto'
      @players=['o','t']
    else
      @players=['red','blue']
    end
    @type = type
    @state = Matrix.build(6,7) {Disc.new()}
    @currentTurn = 0
    @view = gview
  end

  def updateViews()
    @view.update()
  end

  #will only make the move if its the players turn
  def makeMove(move, player)
    placed = nil

    if(@pturn[currentTurn] == player)
      placed = false
      for i in 6..0
        if(@state.element(i,move).type=='empty')
          @state.element(i,move).type = players[currentTurn]
          placed = true
          if(win(i, move, currentTurn))
            puts "Player #{currentTurn+1} wins"
            updateViews()
            #TODO end game here somehow
            return true
          end
          self.currentTurn = (currentTurn + 1) %2

          #makes computer move, there should be a better way to do this...
          if (@pTurn[currentTurn].name != 'human')
            if (@pTurn[currentTurn].name != 'bot_easy')
              level = 0
            else
              level = 1
            end
            makeMove(Computer.makeMove(level, self, @pTurn[currentTurn]), @pTurn[currentTurn])
          end
          ###

          break
        end
      end

      if placed == false
        puts 'no room in column'
      else 
        updateViews()
        return true
      end
    end
    return false
  end

  #TODO check win for TOOT/OTTO
  def win(rows, cols, currentTurn)
    count = 0

    #check rows for win
    game.state.row(rows).each do |p|
      if count == 4
        return true
      end
      if p.type == players[currentTurn]
        count = count + 1
      else
        count = 0
      end
    end
    
    #check columns for win
    count = 0
    game.state.column(cols).each do |p|
      if count == 4
        return true
      end
      if p.type == players[currentTurn]
        count = count + 1
      else
        count = 0
      end
    end

    #check diagonals for win
    count = 0
    total = rows + cols
    if (total < 9 && total > 2)
      for c in 0..6
        if count == 4
          return true
        end
        if game.state.element(total-c, c).type == players[currentTurn]
          count = count + 1
        end
      end
    end
    
    count = 0
    total = (rows - cols).abs
    if total < 4
      for c in 0..6
        if count == 4
          return true
        end
        if game.state.element(total+c, c).type == players[currentTurn]
          count = count + 1
        end
      end
    end

    return false
  end

end
