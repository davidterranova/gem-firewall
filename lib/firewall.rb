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

    def allowed? *args
      allowed = @default
      @rules.each do |rule|
        if rule.kind_of? ComplexRule
          value = (args.length > 1) ? args[1] : nil
          allowed = (allowed || rule.pass?(args[0], value))
        else
          allowed = (allowed || rule.pass?(args[0]))
        end
      end

      allowed
    end

  end
end
