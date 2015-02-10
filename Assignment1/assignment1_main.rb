require './sparse_matrix.rb'
require 'matrix.rb'

#create a blank sparse matrix using dimensions
result = SparseMatrix.new(3,8)

#create a sparse matrix from a ruby matrix
m = Matrix[ [25, 0], [0, 66], [0, 0] ]
result = SparseMatrix.new(m)

#create a sparse matrix from a hash
h = {[1,1]=>2,[2,2]=>-4,[3,3]=>6};
result = SparseMatrix.new(h)

#add/subtract each element of sparse matrix by a scalar
m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
result = m1.plus(2)
result = m1.minus(2)

#add/subtract 2 sparse matrices together
m2 = SparseMatrix.new({[1,1]=>-2,[2,2]=>4,[3,3]=>-6})    
result = m1.plus(m2)
result = m1.minus(m2)

#add/subtract to a specific element of sparse matrix
result = m1.plus(2, 2, 2)
result = m1.minus(2, 2, 2)

#multiply/divide each element of sparse matrix by a scalar
result = m1.mult(2)
result = m1.div(2)

#multiply/divide 2 sparse matrices together
result = m1.mult(m2)
#result = m1.div(m2)

#multiply/divide to a specific element of sparse matrix
m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
result = m1.mult(2, 2, 2)
result = m1.div(2, 2, 2)
  
#get an identity matrix
result = SparseMatrix.eye(3)

#replace all nonZeroes in sparse matrix
result = m1.replNonZero(1)

#get ruby matrix from sparse matrix
result = m1.full()

#print matrix
m1 = SparseMatrix.new({[1,1]=>2,[2,2]=>-4,[3,3]=>6})
puts m1