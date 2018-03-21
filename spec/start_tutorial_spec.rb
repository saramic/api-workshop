require 'spec_helper'

RSpec.describe 'start tutorial' do
  it 'returns a welcome messge to get you started' do
    get '/'
    expect(last_response.body).to eq 'Hi and welcome to the API tutorial'
  end
end

