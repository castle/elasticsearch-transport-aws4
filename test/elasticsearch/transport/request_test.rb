# frozen_string_literal: true

require 'test_helper'
require 'faraday'

describe Faraday::Request do
  describe '#endpoint' do
    it 'strips excess slashes from URL' do
      @request = Faraday::Request.new(
        :get, '/it//is', {}
      )

      @request.endpoint.to_s.must_equal("/it/is")
    end
  end
end
