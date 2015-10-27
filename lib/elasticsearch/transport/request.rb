require "faraday"

module Faraday
  class Request
    def endpoint
      URI.parse(self.path)
    end

    def http_method
      self.method.to_s.upcase
    end
  end
end
