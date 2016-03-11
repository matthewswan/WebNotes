require 'socket'

class Notes
  class Web
    attr_accessor :app, :hash
    def initialize(app, hash)
      @app = app
      @hash = hash
      @server = TCPServer.new hash[:Host], hash[:Port]
    end

    def stop
      socket.close
    end

    def start
      socket = server.accept
      socket.puts request
    end

    def self.parser(socket)
      env = {}
      method, path, version = socket.gets.split
      env['REQUEST_METHOD'] = method
      env['PATH'] = path
      env['VERSION'] = version
      until (line = socket.gets) == "\r\n" do
        header_values = line.split(':')
        key = header_values[0]
        value = header_values[1..-1].join.strip
        env[key] = value
      end
      env
    end
  end
end


  #headers['Content-Length'] = body.length.to_s
  #[status, headers, body.lines]
#end

#Rack::Handler.default.run app, Port: 9292, Host: 'localhost'


# We know that this creates an object with a #call method.
# So a valid rack app is anything with a call method
# that can take the parsed web request as a hash named `env`,
# and return an array with the status, headers, and body lines.
#app = Proc.new do |env|
#  status  = 200
#  headers = {'Content-Type' => 'text/html', 'Content-Length' => '17', 'omg' => 'bbq'}
#  body    = 'hello, class ^_^'

  # Check out the local variable, `env`, that's what you need to parse the request to look like
  # Take the time to look at all the values and see how they came in from the request
  # Hypothesize about what they mean, etc.
  # Check out the unparsed request with `nc -l 4200`
  # Submit the form and figure out how that data becomes available to you

#  headers['Content-Length'] = body.length.to_s
#  [status, headers, body.lines]
#end


#Rack::Handler.default.run app, Port: 9292, Host: 'localhost'
