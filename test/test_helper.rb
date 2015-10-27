$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "elasticsearch/transport/aws4"

require "minitest/spec"
require "minitest/autorun"

require "timecop"
require "webmock/minitest"

WebMock.disable_net_connect!
