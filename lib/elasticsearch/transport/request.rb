# frozen_string_literal: true

require 'faraday'

module Faraday
  # Monkey patching Faraday to avoid issues with excess slashes
  class Request
    def endpoint
      uri = if params.any?
        "#{path}?#{Faraday::Utils::ParamsHash[params].to_query}"
      else
        path
      end

      URI.parse(uri.gsub(%r{([^:])\/{2,}}, '\1/'))
    end

    def http_method
      method.to_s.upcase
    end
  end
end
