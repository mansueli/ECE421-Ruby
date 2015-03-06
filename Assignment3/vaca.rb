class Vaca
  public
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def comparato(other)
    self.age.to_i <= other.age.to_i
  end
end