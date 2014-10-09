require "firewall/version"
require "ipaddress"
require "rule"
require "complex_rule"

module Firewall
  class Firewall

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
