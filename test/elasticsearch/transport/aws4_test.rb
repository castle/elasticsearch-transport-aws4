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
  end

  after do
    Timecop.return
  end

  it "adds Authorization header" do
    @client.search
    assert_requested(
      :get,
      "https://search-xyz-abcdefghijklmmnopqrtuvwxyz.us-east-1.es.amazonaws.com/_search",
      headers: {
        "Authorization"        => /.+/,
        "X-Amz-Content-Sha256" => /.+/,
        "X-Amz-Date"           => "20150101T110000Z"
      }
    )
  end
end
