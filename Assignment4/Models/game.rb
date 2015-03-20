require '../Models/disc.rb'
require '../Views/game_view.rb'
require 'singleton'
require 'observer'
class Game
  include Singleton
  include Observable
  attr_accessor :type, :state, :currentTurn
  attr_reader :players

  def newGame(type)
    if type == 'otto'
      @players=['o','t']
      else
      @players=['red','blue']
    end
    @type = type
    @state = Matrix.build(6,7) {Disc.new()}
    @currentTurn = true
    @view = GameView.instance
  end
 
  def updateViews()

  end
  
  def makeMove(move)
    if(currentTurn)
      for i in 6..0
        if(@state.element(i,move).type=='empty')
          @state.element(i,move).type==players[0]
          break
        end
      end
    else
      for i in 6..0
        if(@state.element(i,move).type=='empty')
          @state.element(i,move).type==players[1]
          break
        end
      end
    end
    self.currentTurn = !currentTurn
    updateViews()
  end
 end
