module Firewall
  class ComplexRule < Rule

    def initialize(ip, allowed, check = {delegate: nil, method: nil, value: nil})
      super(ip, allowed)
      @delegate = check[:delegate]
      @method = check[:method]
      @value = check[:value]
    end

    def pass?(ip, value = nil)
      pass = false
      if @delegate
        pass = (super(ip) and (value == @delegate.send(@method)))
      elsif @value
        pass = (super(ip) and (value == @value))
      else
        pass = super(ip)
      end

      pass
    end

  end
end
