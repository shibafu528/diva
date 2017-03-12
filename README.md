# Pluggaloid for mruby

[diva](https://github.com/toshia/diva) gemをmrubyにポーティングしたものです。

## Installation

Add conf.gem line to your `build_config.rb`:

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'shibafu528/mruby-diva'
end
```

## Contributing

1. Fork it ( https://github.com/shibafu528/mruby-diva/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
