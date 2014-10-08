require 'spec_helper'

class FirewallTest < Minitest::Unit::TestCase

  def setup
    @fw = Firewall::Firewall.new
  end

  def test_no_rule
    ip = "192.168.1.10/32"

    assert_equal @fw.allowed?(ip), false
  end

  def test_no_rule_true
    @fw = Firewall::Firewall.new(true)
    ip = "192.168.1.10/32"

    assert_equal @fw.allowed?(ip), true
  end

  def test_same_ip_pass
    ip = "192.168.1.10/32"
    r1 = Firewall::Rule.new(ip, true)
    @fw.add_rule r1

    assert_equal @fw.allowed?(ip), true
  end

  def test_same_ip_block
    ip = "192.168.1.10/32"
    r1 = Firewall::Rule.new(ip, false)
    @fw.add_rule r1

    assert_equal @fw.allowed?(ip), false
  end

  def test_network_blocked
    network = "192.168.1.0/24"
    ips = IPAddress.parse(network).hosts

    r1 = Firewall::Rule.new(network, false)
    @fw.add_rule r1

    ips.each do |ip|
      assert_equal @fw.allowed?(ip.to_string), false
    end
  end

  def test_network_pass
    network = "192.168.1.0/24"
    ips = IPAddress.parse(network).hosts

    ip = "192.168.1.10/24"

    r1 = Firewall::Rule.new(network, true)
    @fw.add_rule r1

    ips.each do |ip|
      assert_equal @fw.allowed?(ip.to_string), true
    end
  end

  def test_out_of_network_blocked
    network = "192.168.1.0/24"
    ip = "192.168.2.10/24"

    r1 = Firewall::Rule.new(network, true)
    @fw.add_rule r1

    assert_equal @fw.allowed?(ip), false
  end

  def test_out_of_network_blocked_2
    network = "192.168.1.0/24"
    ip = "192.168.2.10/24"

    r1 = Firewall::Rule.new(network, false)
    @fw.add_rule r1

    assert_equal @fw.allowed?(ip), false
  end

  def test_block_allowed
    network = "192.168.1.0/24"
    ip = "192.168.1.10"

    r1 = Firewall::Rule.new(network, false)
    r2 = Firewall::Rule.new(network, true)
    @fw.add_rule r1
    @fw.add_rule r2

    assert_equal @fw.allowed?(ip), true
  end

  def test_block_allowed_2
    network = "192.168.1.0/24"
    ip = "192.168.1.10"

    r1 = Firewall::Rule.new(network, false)
    r2 = Firewall::Rule.new(network, true)
    @fw.add_rule r2
    @fw.add_rule r1

    assert_equal @fw.allowed?(ip), true
  end

end
