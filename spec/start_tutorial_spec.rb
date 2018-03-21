require 'spec_helper'

RSpec.describe 'start tutorial' do
  it 'returns a welcome message as text to get you started' do
    expected_welcome_message = <<-EOF.gsub(/^[ \t]+/, '')
      Hi and welcome to the API tutorial

      you will want to follow along using the unix tools curl and jq to simplify
      reading the JSON output. We will also send a content type header to get
      application/json content. let's give it a go

      curl -H Accept:application/json http://localhost:4567
    EOF

    get '/'
    expect(last_response.headers).to include("Content-Type"=>"text/plain")
    expect(last_response.body).to eq expected_welcome_message
  end

  it 'returns 200 OK' do
    get '/'
    expect(last_response.status).to eq 200
  end

  it 'returns a successful completed challenge 0 if Accept header was included' do
    header 'Accept', 'application/json'
    get '/'
    expect(last_response.headers).to include("Content-Type"=>"application/json")
    expect(JSON.parse(last_response.body)).to include(
      'message' => "Successfully completed challenge 0, hit API with content-type 'application/json'"
    )
  end

  it 'returns a links section in the response with self and next' do
    header 'Accept', 'application/json'
    get '/'
    expect(JSON.parse(last_response.body)).to include(
      'links' => {
        'self' => 'http://example.org',
        'next' => 'http://example.org/challenge/1'
      }
    )
  end

  it 'has a further challenge 1' do
    header 'Accept', 'application/json'
    get '/challenge/1'
    expect(JSON.parse(last_response.body)).to include(
      'data' => {
        'type' => 'challenge',
        'id' => '1',
        'attributes' => {
          "text" => "provide an endpoint that responds with a 200 OK",
          "hint" => "pass your endpoint `curl --data {'endpoint'='http://localhost:3000'} ..."
        }
      },
    )
    expect(JSON.parse(last_response.body)).to include(
      'links' => {
        'prev' => 'http://example.org',
        'self' => 'http://example.org/challenge/1',
        'next' => 'http://example.org/challenge/2'
      }
    )
  end
end

