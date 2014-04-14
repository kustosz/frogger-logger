require 'em-websocket'
require 'frogger-logger/logger'

module FroggerLogger
  def self.init(host = "0.0.0.0", port = 8080)
    Thread.new do
      EM.run do
        channel = EM::Channel.new
        Logger.init(channel)
        EM::WebSocket.start(host: host, port: port) do |ws|
          ws.onopen do
            sid = channel.subscribe do |msg|
              ws.send msg
            end
            ws.onclose do
              channel.unsubscribe(sid)
            end
          end
        end
      end
    end
  end

  def self.log(message)
    Logger.log(message)
  end
end
