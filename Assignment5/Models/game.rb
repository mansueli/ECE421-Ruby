require '../Models/disc.rb'
require '../Models/computer.rb'
require '../Views/game_view.rb'
#require '../contracts.rb'
require 'singleton'
require 'observer'
require 'matrix'

class Game
  include Singleton
  include Observable
  include Computer
  #include Contracts
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

  def updateViews(val = false)
    @view.update(val)
  end

  #will only make the move if its the players turn
  def makeMove(move, player)
    #Contracts.makeMove_pre(player, move, self)
    placed = nil

    if(@pTurn[currentTurn].eql? player)
      
      placed = false
      for i in 0..5
        if(@state.element(5-i,move).type == 'empty')
          @state.element(5-i,move).type = players[currentTurn]
          placed = true
          if(draw())
            puts "Game is draw"
            updateViews(true)
            #TODO end game here somehow
            return true
          end

          if(win(5-i, move, currentTurn))
            puts "Player #{currentTurn+1} wins"
            updateViews(true)
            #TODO end game here somehow
            return true
          end
          self.currentTurn = (currentTurn + 1) %2

          #makes computer move, there should be a better way to do this...
          if (@pTurn[currentTurn].type != 'human')
            if (@pTurn[currentTurn].type != 'bot_easy')
              level = 0
            else
              level = 1
            end
            makeMove(Computer.makeMove(level, self, @pTurn[currentTurn]), @pTurn[currentTurn])
            if(win(5-i, move, currentTurn))
	      puts "Player #{currentTurn+1} wins"
	      updateViews(true)
	      #TODO end game here somehow
              return true
            end
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

  def draw()
    @state.row_vectors.each do |r|
      r.to_a.each do |e|
        if (e.type == 'empty')
          return false
        end
      end
    end
    return true
  end


  def win(rows, cols, currentTurn)
    if (@type == 'otto') 
      #check rows for win
      val = ""
      @state.row(rows).each do |p|
        val = val + p.type
      end
      
      if (val.include? "otto" )|| (val.include? "toot")
	return true
      end
    
      #check columns for win
      val = ""
      @state.column(cols).each do |p|
        val = val + p.type
      end

      if (val.include? "otto") || (val.include? "toot")
	return true
      end

      #check diagonals for win
      val = ""
      total = rows + cols
      if (total < 9 && total > 2)
        for c in 0..6
          if (total - c) >= 0 && (total + c) < 6
            val = val + @state.element(total-c, c).type
          end          
        end
      end

      if (val.include? "otto") || (val.include? "toot")
	return true
      end
    
      count = 0
      total = (rows - cols).abs
      if total < 4
        for c in 0..6
          if (total + c) < 6
            val = val + @state.element(total+c, c).type
          end
        end
      end
     
      if (val.include? "otto") || (val.include? "toot")
	return true
      end

      return false

    else

      count = 0

      #check rows for win
      @state.row(rows).each do |p|
        if p.type == players[currentTurn]
          count = count + 1
        else
          count = 0
        end
        if count == 4
          return true
        end
      end
    
      #check columns for win
      count = 0
      @state.column(cols).each do |p|
        if p.type == players[currentTurn]
          count = count + 1
        else
          count = 0
        end
        if count == 4
          return true
        end
      end

      #check diagonals for win
      count = 0
      total = rows + cols
      if (total < 9) && (total > 2)
        for c in 0..6
          if (total - c) >= 0 && (total + c) < 6
            if @state.element(total-c, c).type == players[currentTurn]
              count = count + 1
            else
              count = 0
            end
            if count == 4
              return true
            end
          end
        end
      end
    
      count = 0
      total = (rows - cols).abs
      if total < 4
        for c in 0..6
          if (total + c) < 6
            if @state.element(total+c, c).type == players[currentTurn]
              count = count + 1
            else
              count = 0
            end
            if count == 4
              return true
            end
          end          
        end
      end

      return false
    end
  end

end
