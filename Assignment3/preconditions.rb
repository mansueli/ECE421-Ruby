require './contract_violation'
module Preconditions
  def is_trivial_block?(&block)
    raise ContractViolation "Trivial Block is not allowed" if block == Proc.new {}
  end

  def is_enumerable?(array)
    raise Contract Violation array.all? { |i| i.is_a? Fixnum }
  end

  def is_number?(x)
    raise ContractViolation "This parameter should be an Integer" unless x.respond_to? (:to_i)
  end
end