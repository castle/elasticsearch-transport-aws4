require "faraday"

module Faraday
  class Request
    def endpoint
      URI.parse(
        self.params.any? ?
          "#{self.path}?#{params.map { |key, value| "#{key}=#{value}" }.join("&")}" :
          self.path
      )
    end

    def http_method
      self.method.to_s.upcase
    end
  end
end
