require "elasticsearch/transport/transport/serializer/multi_json"
require "elasticsearch/transport/transport/base"
require "elasticsearch/transport/transport/http/faraday"
require "elasticsearch/transport/request"
require "aws-sdk-core/signers/v4"
require "aws-sdk-core/credentials"
require "seahorse/util"

require "aws-sdk-core/checksums"
require "aws-sdk-core/endpoint_provider"
require "aws-sdk-core/json"
require "aws-sdk-core/partitions"

module Elasticsearch
  module Transport
    class AWS4 < Elasticsearch::Transport::Transport::HTTP::Faraday
      def initialize(arguments = {}, &block)
        super arguments

        @signer = Aws::Signers::V4.new(
          Aws::Credentials.new(
            arguments[:options][:aws4][:key],
            arguments[:options][:aws4][:secret]
          ),
          "es",
          arguments[:options][:aws4][:region]
        )
      end

      def perform_request(method, path, params = {}, body = nil)
        Elasticsearch::Transport::Transport::Base.instance_method(:perform_request).bind(self).call(method, path, params, body) do |connection, url|
          connection.connection.run_request(
            method.downcase.to_sym,
            url,
            (body ? __convert_to_json(body) : ""),
            {}
          ) do |request|
            @signer.sign(request)
          end
        end
      end
    end
  end
end
