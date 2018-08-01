# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'elasticsearch/transport/aws4'

require 'minitest/spec'
require 'minitest/autorun'

require 'timecop'
require 'webmock/minitest'

WebMock.disable_net_connect!
