# Signature Version 4 Elasticsearch Transport for Amazon Elasticsearch Service

`elasticsearch-transport-aws4` signs [Amazon Elasticsearch Service](https://aws.amazon.com/elasticsearch-service/) requests using [Signature Version 4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "elasticsearch-transport-aws4", "~> 0.1.0"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elasticsearch-transport-aws4

## Usage

Create Elasticsearch client with `transport_class` and `aws4` options.

```ruby
Elasticsearch::Client.new(
  url:             "https://search-XYZ-ABCDEFGHIJKLMMNOPQRTUVWXYZ.us-east-1.es.amazonaws.com",
  transport_class: Elasticsearch::Transport::AWS4,
  aws4: {
    key:    "KEY_KEY_KEY_KEY",
    secret: "SECRET_SECRET",
    region: "us-east-1"
  }
)
```
