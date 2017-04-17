require 'faraday'
require 'json'
require 'time'
require 'rspec'
require 'yaml'

config = YAML.load_file('support/config.yml')

EDMUNDS_KEY = config['EDMUNDS_KEY']
MAX_ATTEMPTS = 6
SLEEP_BASE = 4
SLEEP_RAND = 3

def TestAPI(make, model, year)
    puts 'https://api.edmunds.com/api/vehicle/v2/%s/%s/%s?view=full&fmt=json&api_key=%s' % [make, model, year, EDMUNDS_KEY]
    conn = Faraday.new(:url =>  'https://api.edmunds.com/api/vehicle/v2/%s/%s/%s?view=full&fmt=json&api_key=%s' % [make, model, year, EDMUNDS_KEY])
    res = conn.get
    parsed_body = JSON.parse(res.body)

    if (res.status == 403)
        puts '****** Status: ', res.status
        # return TestAPI(make, model, year)

    elsif (res.status == 404) # No match found
      puts '****** Response Status *******', res.status
      puts '***** Record not found *****'
      return {}

    elsif (res.status != 200) # Found a matching record
        puts '****** Response Status *******', res.status
        return {}
    else  # Successful request status 200
        puts '****** Response Status *******', res.status
        puts '******  Record Found *****'
        # Assert against the parsed content.
        RSpec.describe 'Fetching for car that matches your criteria' do
            it 'Returned result matching criteria' do
                expect(parsed_body['make']['name']).to eq(make)
                expect(parsed_body['model']['niceName']).to eq(model)
                expect(parsed_body['year']).to eq(year)
                puts (parsed_body['make'])
            end
        end
    end
end

TestAPI('Honda', 'civic', 2016)
#TestAPI('Honda', 'civic', 1950)