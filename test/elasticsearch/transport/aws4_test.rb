require "test_helper"
require "elasticsearch"

describe Elasticsearch::Transport::AWS4 do
  before do
    Timecop.freeze(Time.local(2015, 01, 01, 12, 0, 0))

    @client = Elasticsearch::Client.new(
      url:             "https://search-XYZ-ABCDEFGHIJKLMMNOPQRTUVWXYZ.us-east-1.es.amazonaws.com",
      transport_class: Elasticsearch::Transport::AWS4,
      aws4: {
        key:    "KEY_KEY_KEY_KEY",
        secret: "SECRET_SECRET",
        region: "us-east-1"
      }
    )

    @request = stub_request(
      :get,
      "https://search-xyz-abcdefghijklmmnopqrtuvwxyz.us-east-1.es.amazonaws.com/_search"
    ).with(
      headers: {
        "Accept"               => "*/*",
        "Accept-Encoding"      => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization"        => /AWS4-HMAC-SHA256 Credential=KEY_KEY_KEY_KEY\/20150101\/us-east-1\/es\/aws4_request, SignedHeaders=host;user-agent;x-amz-content-sha256;x-amz-date, Signature=.*/,
        "Content-Type"         => "application/x-www-form-urlencoded",
        "Host"                 => "search-XYZ-ABCDEFGHIJKLMMNOPQRTUVWXYZ.us-east-1.es.amazonaws.com",
        "User-Agent"           => "Faraday v0.9.2",
        "X-Amz-Content-Sha256" => "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
        "X-Amz-Date"           => "20150101T110000Z"
      }
    ).to_return(status: 200, body: "", headers: {})
  end

  after do
    Timecop.return
  end

  it "adds Authorization header" do
    @client.search
    assert_requested @request
  end
end
