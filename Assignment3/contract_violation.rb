=begin
      Parallel Sorter - ECE 421 Assignment 3
      @Authors Rodrigo Mansueli & Andy Yao

      Description: Contract Violation class
=end
class ContractViolation < StandardError
  DEFAULT_MESSAGE = "Contract Violation"

  # Exception
  # @param e exception
  # @param msg [String] error message

  def self.[](e, msg = DEFAULT_MESSAGE)
    e2 = new(e)
    raise e2, "#{msg}: #{e.message}"
  end
end