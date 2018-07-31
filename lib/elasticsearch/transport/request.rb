# frozen_string_literal: true

require 'faraday'

# Monkey patching Faraday to avoid issues with excess slashes
module Faraday
  class Request
    def endpoint
      URI.parse(
        (
          params.any? ?
            "#{path}?#{Faraday::Utils::ParamsHash[params].to_query}" :
            path
        ).gsub(%r{([^:])\/{2,}}, '\1/')
      )
    end

    def http_method
      method.to_s.upcase
    end
  end
end
