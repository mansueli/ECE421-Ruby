class Player
  
  attr_accessor :type, :name

  def initialize()
    @type = 'empty'
    @name = ''
    @allowed_types = ['human', 'server_human','bot_easy','bot_hard']
  end

  def type=(x)
    @type = x if (@allowed_types.include?(x))
  end
end
