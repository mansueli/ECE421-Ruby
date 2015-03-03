module Driver
  @time = 1
  @message = "default message"

  def self.exec(arg)
    unless args.empty? do
      @time = arg if arg.is_a?(Integer)
      @message = arg if arg.is_a?(String)
    end
      displayMessages()
    end
  end

  def self.exec(message, delay)
    raise "invalid input " unless (delay.is_a?(Integer) or message.is_a?(String))
    @time = delay
    @message = message
    displayMessages()
  end


  def displayMessages()
    t = Time.now.nsec + @time
    loop do
      if t <= Time.now.nsec
        print(@message)
        t = Time.now.nsec + @time
      end
    end
  end

end