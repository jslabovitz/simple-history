require 'json'
require 'time'

module Simple

  class History

    def initialize(file=nil)
      @file = file&.to_s
      @entries = {}
      load if @file && File.exist?(@file)
    end

    def load
      raise "No file" unless @file
      @entries = JSON.parse(File.read(@file)).map { |key, time| [key, Time.parse(time)] }.to_h
    end

    def save
      raise "No file" unless @file
      File.write(@file, JSON.pretty_generate(@entries))
    end

    def reset
      @entries.clear
      save if @file
    end

    def prune(before:, &block)
      @entries.delete_if { |key, time|
        t = (time < before)
        yield(key, time) if t && block_given?
        t
      }
      save if @file
    end

    def keys
      @entries.keys
    end

    def include?(key)
      @entries.include?(key.to_s)
    end

    def [](key)
      @entries[key.to_s]
    end

    def []=(key, time)
      @entries[key.to_s] = time
      save if @file
    end

    def latest_entry
      @entries.sort_by(&:last).last
    end

    def latest_key
      latest_entry.first
    end

    def latest_time
      latest_entry.last
    end

  end

end