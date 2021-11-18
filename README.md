# kemal-flash

![Crystal CI](https://github.com/crystal-garage/kemal-flash/workflows/Crystal%20CI/badge.svg?branch=develop)
[![GitHub release](https://img.shields.io/github/release/crystal-garage/kemal-flash.svg)](https://github.com/crystal-garage/kemal-flash/releases)
[![License](https://img.shields.io/github/license/crystal-garage/kemal-flash.svg)](https://github.com/crystal-garage/kemal-flash/blob/develop/LICENSE)

> A fork of the [kemal-flash](https://github.com/neovintage/kemal-flash) library that I created because the original not working anymore and has not received any updates for a long time.

`kemal-flash` provides a way to pass temporary information between actions. Anything
that's placed in the flash will be cleared out at the end of the next action. `kemal-flash`
depends on `kemal-session`. Make sure `kemal-session` is included before including
`kemal-flash`.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kemal-flash:
    github: crystal-garage/kemal-flash
    branch: develop
```

## Usage

```crystal
require "kemal"
require "kemal-session"
require "kemal-flash"

get "/" do |env|
  env.flash["notice"] = "welcome"
end

get "/check_flash" do |env|
  env.flash["notice"]?
end
```

## Contributing

1. Fork it ( https://github.com/crystal-garage/kemal-flash/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [neovintage](https://github.com/neovintage) Rimas Silkaitis - creator, maintainer
- [mamantoha](https://github.com/mamantoha) Anton Maminov - maintainer
