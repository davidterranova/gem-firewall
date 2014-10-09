module Firewall
  class ComplexRule < Rule

    def initialize(ip, allowed, check = {delegate: nil, method: nil})
      super(ip, allowed)
      @delegate = check[:delegate]
      @method = check[:method]
    end

    def pass?(ip, value = nil)
      pass = false
      if @delegate
        pass = (super(ip) and (value == @delegate.send(@method)))
      else
        pass = super(ip)
      end

      pass
    end

  end
end
