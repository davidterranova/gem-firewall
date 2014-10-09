module Firewall
  class Rule

    def initialize(ip, allowed)
      @ip = IPAddress.parse ip
      @allowed = allowed
    end

    def ip
      @ip
    end

    def allowed
      @allowed
    end

    def pass? str_ip
      value = false
      ip = IPAddress.parse str_ip

      if @ip.prefix == 32 or ! @ip.network? # single address
        if @ip.address == ip.address
          value = @allowed
        end
      else # network
        if @ip.include?(ip)
          value = @allowed
        end
      end

      if @ip.address == "0.0.0.0"
        value = @allowed
      end

      value
    end

    def to_s
      "#{@ip.to_string} - #{@allowed}"
    end

  end
end
