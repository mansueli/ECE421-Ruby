gem "minitest"
require 'minitest/autorun'
require './sparse_matrix'
require 'contracts'
include Contracts

class TestSparseMatrix<Minitest::Test
  
  def test_initialize
    test = SparseMatrix.new(3,8)
    
    assert(test.col_number>0)
    assert(test.row_number>0)
    #assert(test.elements) how to tets hash?
    assert(test.is_a?SparseMatrix)
  end
end