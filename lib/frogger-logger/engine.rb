if defined? Rails
  module FroggerLogger
    module Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end