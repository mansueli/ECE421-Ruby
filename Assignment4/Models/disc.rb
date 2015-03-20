class Disc
  @allowed_types = ['empty','blue','red','t','o']
  @type = ''
  def initialize()
    @type = 'empty'
  end

  def type=(x)
    @type = x if (@allowed_types.include?(x))
  end
end