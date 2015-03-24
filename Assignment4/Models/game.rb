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
      end
    end
  end

end
