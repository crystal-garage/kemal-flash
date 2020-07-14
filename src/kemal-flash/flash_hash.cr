module Kemal::Flash
  class FlashHash
    include JSON::Serializable
    include Session::StorableObject

    property values : Hash(String, String)
    setter discard : Set(String)

    forward_missing_to @values

    def self.from_json(string_or_io)
      parser = JSON::PullParser.new(string_or_io)
      flash_hash = self.new(parser)
      flash_hash.sweep

      flash_hash
    end

    def to_json(json : ::JSON::Builder)
      @values.reject!(@discard.to_a)
      @discard.clear

      super
    end

    def initialize
      @values = Hash(String, String).new
      @discard = Set(String).new
    end

    def update(h : Hash(String, String))
      @discard.subtract(h.keys)
      @values.merge!(h)
    end

    def []=(k : String, val : String)
      @values[k] = val
      @discard.delete(k)
    end

    def [](k : String)
      @discard.add(k)
      @values[k]
    end

    def []?(k : String)
      @discard.add(k)
      @values[k]?
    end

    # Discards the key at the end of the current action
    #
    def discard(key : String)
      @discard.add(key)
    end

    # Discards all keys at the end of the current action
    #
    def discard
      @discard.concat(@values.keys)
    end

    # Will remove any values that are in the discard set
    # and any keys that weren't rejected will now be up for
    # discard at the end of the current action
    #
    def sweep
      @values.reject!(@discard.to_a)
      @discard = Set(String).new(@values.keys)
    end
  end
end
