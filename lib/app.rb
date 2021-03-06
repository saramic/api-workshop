require 'sinatra'

get '/' do
  if !request.accept?('text/html')
    headers 'Content-Type' => 'application/json'
    body({
      message: "Successfully completed challenge 0, hit API with content-type 'application/json'",
      links: {
        self: "#{request.base_url}",
        next: "#{request.base_url}/challenge/1"
      }
    }.to_json)
    return
  end
  headers 'Content-Type' => 'text/plain'
  body <<-EOF.gsub(/^[ \t]+/, '')
    Hi and welcome to the API tutorial

    you will want to follow along using the unix tools curl and jq to simplify
    reading the JSON output. We will also send a content type header to get
    application/json content. let's give it a go

    curl -H Accept:application/json http://localhost:4567
  EOF
end

get '/challenge/:id' do
  {
    'data' => {
      'type' => 'challenge',
      'id' => '1',
      'attributes' => {
        'text' => 'provide an endpoint that responds with a 200 OK',
        'hint' => "pass your endpoint `curl --data {'endpoint'='http://localhost:3000'} ..."
      }
    },
    'links' => {
      'prev' => 'http://example.org',
      'self' => 'http://example.org/challenge/1',
      'next' => 'http://example.org/challenge/2'
    }
  }.to_json
end

post '/challenge/:id' do
  status 422
  {
    'data' => {
      'type' => 'challenge',
      'id' => '1',
      'attributes' => {
        'text' => 'provide an endpoint that responds with a 200 OK',
        'hint' => "pass your endpoint `curl --data {'endpoint'='http://localhost:3000'} ...",
        'status' => 'in progress'
      }
    },
    'links' => {
      'prev' => 'http://example.org',
      'self' => 'http://example.org/challenge/1',
      'next' => 'http://example.org/challenge/2'
    }
  }.to_json
end

