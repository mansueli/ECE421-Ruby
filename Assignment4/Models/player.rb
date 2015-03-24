class Player
  @allowed_types = ['human','bot_easy','bot_hard']
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def initialize()
    @type = 'empty'
  end

  def name=(x)
    @name = x if (@allowed_types.include?(x))
  end
end
