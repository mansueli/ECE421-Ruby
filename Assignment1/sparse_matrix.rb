class SparseMatrix
  # Contracts.ruby (http://egonschiele.github.io/contracts.ruby/)
  # @Author Aditya Bhargava
  #
  require 'contracts'
  require 'matrix.rb'
  include Contracts
  #TODO add invariants

  Contract.override_failure_callback do |data|
    puts Contract::failure_msg(data)
  end

  attr_accessor :elements
  attr_reader :row_number, :col_number, :sparsity

  ### constructor() adds an element to the matrix
  # Params:
  # @row number of rows in the matrix
  # @col number of columns in the matrix
  def initialize(*args)
    if args.size == 1
      if args[0].is_a?Matrix
        init_mat(*args)
      else 
        init_vals(*args)
      end 
    else
      init_dimens(*args)
    end
  end

  Contract And[Fixnum, Pos], And[Fixnum, Pos] => Hash
  def init_dimens(row, col)
    @row_number = row
    @col_number = col
    @elements = Hash.new(0)
  end
  
  Contract Hash => Hash
  def init_vals(elements)
    @row_number = elements.keys.max_by{|k| k[0]}[0] + 1
    @col_number = elements.keys.max_by{|k| k[1]}[1] + 1
    @elements = elements
  end
  
  Contract Matrix => Matrix
  def init_mat(mat)
    @row_number = mat.row_size
    @col_number = mat.column_size
    @elements = Hash.new(0)
    
    mat.each_with_index do |e, row, col|
      @elements[[row,col]] = e if e != 0
    end
  end
  
  Contract Num, Num => nil
  ### scalar() multiplies the matrix by a scalar
  # @value the scalar number
  def scalar(value)
    @elements.each { |key, oldValue| @elements[key] = oldValue * value }
  end

  ### scalar() multiplies the matrix by a scalar
  # @value the scalar number to be added
  def plus(*args)
    smnew = SparseMatrix.new(self.row_number, self.col_number);
    if args.size == 1
      if args[0].respond_to?(:+)
        #TODO 
      else
        #line below errors, undefined method '[]' ??
        #@elements.each { |key, oldValue| smnew.elements[key] = oldValue + value }
      end
    else
      #TODO
    end
    return smnew
  end

  Contract Num => nil
  ### scalar() multiplies the matrix by a scalar
  # @value the scalar number to be subtracted
  def minus(value)
    return plus(-1*value)
  end

  def mult(*args)
    smnew = SparseMatrix.new(self.row_number, self.col_number);
    #TODO
    return smnew
  end
  
  def div(*args)
    inv = *args;  #handle different cases
    #TODO
    return mult(inv);
  end  
    
  def replNonZero(*args)
    smnew = SparseMatrix.new(self.row_number, self.col_number);
    #TODO
    return smnew
  end
  
  def full()
    mnew = Matrix.build(self.row_number, self.col_number){};
    #TODO
    return mnew
  end
  
  Contract Fixnum, Fixnum => SparseMatrix
  def self.eye(row, col)
    smnew = SparseMatrix.new(row, col);
    #TODO
    return smnew
  end
  
  #TODO: should probably constrain the next contracts based on row and column not num
  Contract Not[Neg], Not[Neg], Num => nil
  ### addElement() adds an element to the matrix
  # @raise 'element exists' if the element already exists
  # Params:
  # @row the row in the matrix to put the element
  # @col the column in the matrix to put the element
  # @value the value to put in this position of the matrix
  def addElement(row, col, value)
    raise 'element exists' unless elements[[row, col]] == 0
    if value == 0 && row <= :row_number && col <= :col_number
      elements[[row, col]] = value
    end
    sparsity = elements.count() /(:row_number * :col_number)
  end

  Contract Not[Neg], Not[Neg] => Num
  ### constructor() get an element value from the matrix
  # Params:
  # @row the row where the element is
  # @col the column where the element is
  #
  # @return the requested element
  def getElement(row, col)
    elements[[row, col]]
  end

  def to_s
    (0..@row_number).map { |r|
      (0..@col_number).map { |c|
        self[r, c]}.join(" ")
    }.join("\n")
  end


  Contract nil => Bool
  ### whether this object is a sparse matrix of not
  # @return a boolean value
  def is_sparse?
    :sparsity>0.5
  end
  
  private :init_dimens, :init_vals, :init_mat
end