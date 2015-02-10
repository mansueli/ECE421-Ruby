gem "minitest"
require 'minitest/autorun'
require './sparse_matrix.rb'
require 'matrix.rb'
include Contracts

class TestSparseMatrix<Minitest::Test
  
  def test_initialize_dimens    
    #pre
    rows = 3
    cols = 8
    assert(rows > 0)
    assert(cols > 0)
    
    test = SparseMatrix.new(3,8)
    
    #post
    assert_equal(test.col_number, 8)
    assert_equal(test.row_number, 3)
    assert(test.elements.empty?)
  end
  
  def test_initialize_mat1
    #pre
    m = Matrix.build(8, 3){0}
    assert(m.is_a?Matrix)
    
    test = SparseMatrix.new(m)
    
    #post
    assert_equal(m.column_size, test.col_number)
    assert_equal(m.row_size, test.row_number)
    assert(test.elements.empty?)
  end
  
  def test_initialize_mat2
    #pre
    m = Matrix[ [25, 0], [0, 66], [0, 0] ]
    assert(m.is_a?Matrix)
    
    test = SparseMatrix.new(m)
    
    #post
    assert_equal(m.column_size, test.col_number)
    assert_equal(m.row_size, test.row_number)
    assert_equal(test.elements, {[0, 0]=>25, [1, 1]=>66})
  end
  
  def test_initialize_vals    
    #pre
    m = {[1,1]=>2,[2,2]=>-4,[3,3]=>6};
    assert(m.is_a?Hash)
    
    test = SparseMatrix.new(m)
    
    #post
    assert_equal(4, test.col_number)
    assert_equal(4, test.row_number)
  end
  
  ### plus tests plus and minus are essentially the same
  
  def test_plus_scal
    res = SparseMatrix.new({[1,1]=>4,[2,2]=>-2,[3,3]=>8})
    m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
    # Pre
    assert(m1.respond_to? 'plus')
    
    test = m1.plus(2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  def test_plus_mat
    res = SparseMatrix.new(4,4)
    m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
    m2 = SparseMatrix.new({[1,1]=>-2,[2,2]=>4,[3,3]=>-6})
    # Pre
    assert(m1.respond_to? 'plus')
    assert_equal(m1.col_number, m2.col_number)
    assert_equal(m1.row_number, m2.row_number)
    
    test = m1.plus(m2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  def test_plus_one_element
    res = SparseMatrix.new({[1,1]=>-2,[2,2]=>6,[3,3]=>-6})
    m1 = SparseMatrix.new({[1,1]=>-2,[2,2]=>4,[3,3]=>-6})
    # Pre
    assert(m1.respond_to? 'plus')
    
    test = m1.plus(2, 2, 2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  ### mult tests mult and div are essentially the same
  
  def test_mult_scal
    res = SparseMatrix.new({[1,1]=>4,[2,2]=>-4,[3,3]=>12})
    m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
    # Pre
    assert(m1.respond_to?'plus')
    
    test = m1.mult(2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  def test_mult_mat
    res = SparseMatrix.new({[0,1]=>-4,[1,2]=>-16,[1,4]=>-24, [2,5]=>-36})
    m1 = SparseMatrix.new({[0,1]=>2,[1,2]=>-4,[1,3]=>6})
    m2 = SparseMatrix.new({[1,1]=>-2,[2,2]=>4,[3,6]=>-6})
    # Pre
    assert(m1.respond_to?'mult')
    assert_equal(m1.col_number, m2.row_number)
    
    test = m1.mult(m2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  def test_mult_one_element
    res = SparseMatrix.new({[1,1]=>-2,[2,2]=>8,[3,3]=>-6})
    m1 = SparseMatrix.new({[1,1]=>-2,[2,2]=>4,[3,3]=>-6})
    # Pre
    assert(m1.respond_to?'mult')
    
    test = m1.mult(2, 2, 2)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.col_number, res.col_number)
    assert_equal(test.row_number, res.row_number)
  end
  
  ### tests for other features
  
  def test_sparse_iden_mat
    res = SparseMatrix.new({[0,0]=> 1,[1,1]=>1,[2,2]=>1})
    # Pre
    
    test = SparseMatrix.eye(3)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.row_number, 3)
    assert_equal(test.col_number, 3)
  end
  
  def test_replace_nonzero
    res = SparseMatrix.new({[0,0]=> 1,[0,1]=>1,[2,4]=>1})
    m = SparseMatrix.new({[0,0]=>3,[0,1]=>4,[2,4]=>1})
    # Pre
    assert(m.respond_to?'replNonZero')
    
    test = m.replNonZero(1)
  
    # Post
    assert_equal(test.elements, res.elements)
    assert_equal(test.row_number, 3)
    assert_equal(test.col_number, 5)
  end
  
  def test_convert_full
    res = Matrix[[4,7,0],[0,0,0],[0,0,3]]
    m = SparseMatrix.new({[0,0]=>4,[0,1]=>7,[2,2]=>3})
    # Pre
    assert(m.respond_to?'full')
    
    test = m.full()
  
    # Post
    assert_equal(test, res)
    assert_equal(test.row_size, 3)
    assert_equal(test.column_size, 3)
  end
end