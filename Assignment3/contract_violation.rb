class ContractViolation < StandardError
  attr_reader :cause

  def initialize cause
    @cause = cause
  end

  DEFAULT_MESSAGE = "Contract Violation"

  def self.[](e, msg = DEFAULT_MESSAGE)
    e2 = new(e)
    raise e2, "#{msg}: #{e.message}"
  end
end