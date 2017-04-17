Use http://edmunds.mashery.com/docs/read/The_Vehicle_API to test the following scenarios using Ruby,
RSpec, and Faraday:

1. Search for the make, model, year of your car and verify the response status and that the response body
contains the results that match your criteria.

Get a list of all vehicle makes (new, used and future), their models and years

URL:
https://api.edmunds.com/api/vehicle/v2/{0}/{1}/{2}?fmt=json&api_key={3}'.format(make, model, year, EDMUNDS_KEY)

Possible response status:
200 OK
    The request has succeeded. 
    GET: The resource has been fetched and is transmitted in the message body.
403 Forbidden
    Client does not have access rights to the content so server is rejecting to give proper response.    
404 Not Found
    Server can not find requested resource. 
    
How to run this test:
    1. Clone repository:
        git clone https://github.com/vasquezcarlos/edmundsapi
    2. Bring up the command line console
    3. cd to "edmunds_project" directory
    4. Type "rspec tests/testAPI.rb -fdoc" and press enter
    5. Validate results:
       a. it should find a record
       b. it should display the response status code(e.g 200)
       c. Sent request
    6. Edit testAPI.rb file and comment out the line that reads "TestAPI('Honda', 'civic', 2016)" by adding a "#" at the
       begining of the line.  
    7. Un-comment line that reads "TestAPI('Honda', 'civic', 1950)" by removing the "#" at the begining of the line
    8. At the command line type "rspec tests/testAPI.rb -fdoc" and press enter
    9. Validate results:
       a. it should not find a matching record, this is due to the fact that there were no Honda Civics in 1950
       b. it should display the response status code(e.g 404)
       c. Sent request
       
    Note: I tried to read the arguments from the command line by using *ARGV, but RSpec autorun method has been depecreted
          therefore I had to hard code the arguments that I need to pass to the testAPI function.
