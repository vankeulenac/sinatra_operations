require 'pstore'

class PanelDB
  class << self
    def store
      environment = ENV['RACK_ENV'] || "development"
      db ||= PStore.new("panels_#{environment}.store") 
      db.transaction do |db|
        db["panels"] ||= []
      end
      db
    end

    def add_panel(arg)
      store.transaction do |db|
        db["panels"] << arg
      end
    end

    def all
      store.transaction do |db|
        db["panels"]
      end
    end

    def clear
      store.transaction do |db|
        db["panels"] = []
      end
    end
  end
end
