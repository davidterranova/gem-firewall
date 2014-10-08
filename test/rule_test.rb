require 'spec_helper'

class RuleTest < Minitest::Unit::TestCase

  def test_same_ip_pass
    ip = "192.168.1.10/32"
    r1 = Firewall::Rule.new(ip, true)

    assert_equal r1.pass?(ip), true
  end

  def test_same_ip_block
    ip = "192.168.1.10/32"
    r1 = Firewall::Rule.new(ip, false)

    assert_equal r1.pass?(ip), false
  end

  def test_network_blocked
    network = "192.168.1.0/24"
    ips = IPAddress.parse(network).hosts

    r1 = Firewall::Rule.new(network, false)

    ips.each do |ip|
      assert_equal r1.pass?(ip.to_string), false
    end
  end

  def test_network_pass
    network = "192.168.1.0/24"
    ips = IPAddress.parse(network).hosts

    ip = "192.168.1.10/24"

    r1 = Firewall::Rule.new(network, true)

    ips.each do |ip|
      assert_equal r1.pass?(ip.to_string), true
    end
  end

  def test_out_of_network_blocked
    network = "192.168.1.0/24"
    ip = "192.168.2.10/24"

    r1 = Firewall::Rule.new(network, true)

    assert_equal r1.pass?(ip), false
  end

  def test_out_of_network_blocked_2
    network = "192.168.1.0/24"
    ip = "192.168.2.10/24"

    r1 = Firewall::Rule.new(network, false)

    assert_equal r1.pass?(ip), false
  end

end
