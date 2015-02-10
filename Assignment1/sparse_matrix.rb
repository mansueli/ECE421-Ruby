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
    @elements = elements.delete_if {|k, v| v == 0}
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
  
  def combine(other)
    result = Hash.new(0)
    self.row_number.times do |r|
      self.col_number.times do |c|
        result[[r,c]] = yield(self.getElement(r,c), other.getElement(r,c))
      end
    end
    return SparseMatrix.new(result)
  end
  
  def mcombine(other)
    result = Hash.new(0)
    other.col_number.times do |oc|
      self.row_number.times do |r|
        self.col_number.times do |c|
          result[[r,oc]] += yield(self.getElement(r,c), other.getElement(c,oc))
        end
      end
    end
    return SparseMatrix.new(result)
  end

  def plus(*args)
    smnew = SparseMatrix.new(elements);
    if args.size == 1
      if args[0].respond_to?(:combine)
        smnew = smnew.combine(args[0]) {|e1,e2| e1 + e2}
      else
        elements.each { |key, oldValue| smnew.elements[key] = oldValue + args[0] }
      end
    else
      smnew.elements[[args[0],args[1]]] = elements[[args[0],args[1]]] + args[2]
    end
    return smnew
  end

  Contract Num => nil
  def minus(*args)
    if args.size == 1
      return plus(args[0]*-1)
    else
      args[2] = args[2]*-1
      return plus(*args)
    end
  end

  def mult(*args)
    smnew = SparseMatrix.new(elements);
    if args.size == 1
      if args[0].respond_to?(:mcombine)
        smnew = smnew.mcombine(args[0]) {|e1,e2| e1 * e2}
      else
        elements.each { |key, oldValue| smnew.elements[key] = oldValue * args[0] }
      end
    else
      smnew.elements[[args[0],args[1]]] = elements[[args[0],args[1]]] * args[2]
    end
    return smnew
  end
  
  def div(*args)
    if args.size == 1
        if args[0].respond_to?(:mcombine)
          inv = SparseMatrix.new(args[0].full().inverse())
        else
          inv = 1/args[0]
        end
      else
        args[2] = 1/args[2]
        inv = *args
    end
    return mult(inv);
  end  
  
  Contract Fixnum => SparseMatrix
  def replNonZero(value)
    smnew = SparseMatrix.new(self.elements);
    smnew.elements.each_key{|key| smnew.elements[key] = value}
    return smnew
  end
  
  Contract nil => Matrix
  def full()
    a = []
    self.row_number.times do |r|
      b = []
      self.col_number.times do |c|
        if getElement(r,c) != nil
          b.push(getElement(r,c))
        else
          b.push(0)
        end
      end
      a.push(b)
    end
    
    mnew = Matrix.rows(a)
    return mnew
  end
  
  Contract Fixnum => SparseMatrix
  def self.eye(dimen)
    smnew = SparseMatrix.new(Matrix.identity(dimen))
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
  end

  Contract Not[Neg], Not[Neg] => Num
  ### constructor() get an element value from the matrix
  # Params:
  # @row the row where the element is
  # @col the column where the element is
  #
  # @return the requested element
  def getElement(row, col)
    elements[[row, col]] || 0
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
    sparsity = elements.count() /(:row_number * :col_number)
    :sparsity>0.5
  end
  
  private :init_dimens, :init_vals, :init_mat
  
  alias + plus
  alias - minus
  alias * mult
  alias / div
end