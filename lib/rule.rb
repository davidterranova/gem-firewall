module Firewall
  class Rule

    def initialize(ip, allowed, condition = nil)
      @ip = IPAddress.parse ip
      @allowed = allowed
      @condition = condition
    end

    def ip
      @ip
    end

    def allowed
      @allowed
    end

    def pass? str_ip
      ip = IPAddress.parse str_ip
      if @ip.prefix == 32 or ! @ip.network? # single address
        @ip.address == ip.address ? @allowed : false
      else # network
        @ip.include?(ip) ? @allowed : false
      end
    end

    def to_s
      "#{@ip.to_string} - #{@allowed}"
    end

  end
end
