class Game
  
  attr_accessor :type, :state, :currentturn
   
  def initialize(type)
    @type = type
    @state = Array.new(7){Array.new(6){0}}
    @currentturn = 0
  end
 
  def updateViews(v)
    #TODO
  end
  
  def makeMove(x, y)
    #TODO
    self.currentturn = !currentturn
  end
  
end