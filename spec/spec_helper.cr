require "spec"
require "spec-kemal"
require "../src/kemal-flash"

ENV["KEMAL_ENV"] = "test"

Kemal.config.logging = false
Kemal::Session.config.engine = Kemal::Session::MemoryEngine.new
Kemal::Session.config.secret = "kemal_rocks"

module TestKemalApp
  get "/set_flash" do |context|
    context.flash["notice"] = "successfully created"
    "made it"
  end

  get "/use_flash" do |context|
    context.flash["notice"]?
  end

  get "/use_flash_and_update_it" do |context|
    message = context.flash["notice"]?
    context.flash["notice"] = "#{message}, well done"
  end

  get "/flash_json" do |context|
    context.flash.to_h.to_json
  end

  get "/redirect" do |context|
    context.flash["notice"] = "successfully created"
    context.redirect "/flash_json"
  end
end

spawn { Kemal.run }
