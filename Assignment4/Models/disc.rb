class Disc
  attr_reader :type

  def initialize()
    @type = 'empty'
    @allowed_types = ['empty','blue','red','t','o']
  end

  def type=(x)
    @type = x if (@allowed_types.include?(x))
  end
end
