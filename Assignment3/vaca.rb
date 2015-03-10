=begin
      Array extensions - ECE 421 Assignment 3
      @Authors Rodrigo Mansueli & Andy Yao

      Description: Adds timeout and parallel quick sort to the Class Array
=end
class Vaca
  public
  attr_accessor :name, :age

  #
  # Class Constructor
  # @param name [String]
  # @param age [Numeric]
  def initialize(name, age)
    @name = name
    @age = age
  end

  # Compararison method
  # @param other [Vaca]
  # @return comparison [Boolean] result of comparison method
  def comparato(other)
    self.age.to_i <= other.age.to_i
  end
end