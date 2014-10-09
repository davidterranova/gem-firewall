require 'spec_helper'

class ComplexRuleTest < Minitest::Unit::TestCase

  class Deletest

    def return_true
      true
    end

  end


  def test_with_delegate_allowed
    ip = "192.168.1.10/24"
    ip2 = "192.168.1.10"

    dt = Deletest.new

    r1 = Firewall::ComplexRule.new(ip, true, {delegate: dt, method: :return_true})
    assert_equal r1.pass?(ip2, true), true
  end

  def test_with_delegate_blocked
    ip = "192.168.1.10/24"
    ip2 = "192.168.1.10"

    dt = Deletest.new

    r1 = Firewall::ComplexRule.new(ip, true, {delegate: dt, method: :return_true})
    assert_equal false, r1.pass?(ip2, false)
  end

  def test_complex_rule_as_normal_rule_allowed
    ip = "192.168.1.10/24"
    ip2 = "192.168.1.10"

    dt = Deletest.new

    r1 = Firewall::ComplexRule.new(ip, true)
    assert_equal r1.pass?(ip2), true
  end

  def test_complex_rule_as_normal_rule_blocked
    ip = "192.168.1.10/24"
    ip2 = "192.168.1.10"

    dt = Deletest.new

    r1 = Firewall::ComplexRule.new(ip, false)
    assert_equal r1.pass?(ip2), false
  end

  def test_complex_rule_with_value
    ip = "192.168.1.10/24"

    r1 = Firewall::ComplexRule.new(ip, true, {value: 'value'})
    assert_equal r1.pass?(ip, 'value'), true
    assert_equal r1.pass?(ip, 'plop'), false
  end


end
