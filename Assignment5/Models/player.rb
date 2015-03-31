class Player
  
  attr_accessor :type

  def initialize()
    @type = 'empty'
    @allowed_types = ['human','bot_easy','bot_hard']
  end

  def type=(x)
    @type = x if (@allowed_types.include?(x))
  end
end
