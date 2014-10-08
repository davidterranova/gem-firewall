require "firewall/version"
require "rule"
require "ipaddress"

module Firewall
  class Firewall

    def add(x, y)
      x + y
    end

    def initialize(default = false)
      @default = default
      @rules = []
    end

    def rules
      @rules
    end

    def add_rule rule
      @rules << rule
    end

    def allowed? ip
      allowed = @default
      @rules.each do |rule|
        #puts "Test #{rule} with #{ip}"
        allowed = allowed || rule.pass?(ip)
      end

      allowed
    end

  end
end
