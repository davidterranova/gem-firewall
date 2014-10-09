# Firewall

Very simple firewall

## Installation

Add this line to your application's Gemfile:

    gem 'firewall'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firewall

## Basic usage

- Create a firewall instance

```
fw = Firewall::Firewall.new(false) # reject by default
```

- Add some rules

```
r = Firewall::Rule.new("192.168.1.0/24", true) # allow network
fw.add_rule(r)
```

- Let's check

```
fw.allowed?("192.168.1.15") # true
fw.allowed?("127.0.0.1") # false
```

## Advanced rules

Lets assume you have an object that can do some checks

```
class Deletest

  def complex_check
    true
  end

end
```

```
delegate = Deletest.new

fw = Firewall::Firewall.new(false)
r = Firewall::ComplexRule.new("192.168.1.1", true, {delegate: delegate, method: :complex_check})
fw.add_rule(r)

fw.allowed?("192.168.1.1", true) # true
fw.allowed?("192.168.1.1", false) # false
```

## Contributing

1. Fork it ( https://github.com/davidterranova/firewall/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
