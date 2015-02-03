gem "minitest"
require 'minitest/autorun'
require './sparse_matrix.rb'
include Contracts

class TestSparseMatrix<Minitest::Test
  
  def test_initialize
    
    test = SparseMatrix.new(3,8)
    
    assert(test.col_number>0)
    assert(test.row_number>0)
    #assert(test.elements) how to test hash?
    assert(test.is_a?SparseMatrix)
    
    test = SparseMatrix.new(1.1,8) #contract violation
    test = SparseMatrix.new(0,3) #contract violation
    test = SparseMatrix.new(3,0) #contract violation
  end
end