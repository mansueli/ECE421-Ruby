=begin
      Array extensions - ECE 421 Assignment 3
      @Authors Rodrigo Mansueli & Andy Yao

      Description: Preconditions statements to protect the code
=end
require './contract_violation'
module Preconditions
  def is_trivial_block?(&block)
    raise ContractViolation.exception "Trivial Block is not allowed" if block == Proc.new {}
  end

  def is_enumerable?(array)
    raise ContractViolation.exception array.all? { |i| i.is_a? Fixnum }
  end

  def is_number?(x)
    raise ContractViolation.exception "This parameter should be a number" unless x.is_a? Numeric
  end

  def is_negative?(x)
    raise ContractViolation.exception "Time must be a positive number" unless x>0
  end
end