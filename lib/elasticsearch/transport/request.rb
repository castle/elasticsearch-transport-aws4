require "faraday"

module Faraday
  class Request
    def endpoint
      URI.parse(
        (
          self.params.any? ?
            "#{self.path}?#{Faraday::Utils::ParamsHash[params].to_query}" :
            self.path
        ).gsub(/([^:])\/{2,}/, '\1/')
      )
    end

    def http_method
      self.method.to_s.upcase
    end
  end
end
