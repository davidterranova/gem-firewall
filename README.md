# Firewall

Very simple firewall

## Installation

Add this line to your application's Gemfile:

    gem 'firewall'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firewall

## Usage

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/firewall/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
