# frozen_string_literal: true

require 'test_helper'
require 'elasticsearch'

describe Elasticsearch::Transport::AWS4 do
  before do
    Timecop.freeze(Time.utc(2015, 1, 1, 12, 0, 0))

    @client = Elasticsearch::Client.new(
      url:             'https://search-XYZ-ABCDEFGHIJKLMMNOPQRTUVWXYZ.us-east-1.es.amazonaws.com',
      transport_class: Elasticsearch::Transport::AWS4,
      aws4: {
        key:    'KEY_KEY_KEY_KEY',
        secret: 'SECRET_SECRET',
        region: 'us-east-1'
      }
    )

    @request = stub_request(
      :get,
      'https://search-xyz-abcdefghijklmmnopqrtuvwxyz.us-east-1.es.amazonaws.com/_search'
    ).with(
      headers: {
        'Accept'               => '*/*',
        'Accept-Encoding'      => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'        => /.+/,
        'Content-Type'         => 'application/x-www-form-urlencoded',
        'Host'                 => 'search-XYZ-ABCDEFGHIJKLMMNOPQRTUVWXYZ.us-east-1.es.amazonaws.com',
        'User-Agent'           => /\AFaraday v.*\z/,
        'X-Amz-Content-Sha256' => /.+/,
        'X-Amz-Date'           => '20150101T120000Z'
      }
    ).to_return(status: 200, body: '', headers: {})
  end

  after do
    Timecop.return
  end

  it 'adds Authorization header' do
    @client.search
    assert_requested @request
  end
end
