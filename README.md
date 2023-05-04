# factoring-lender-api

This project fulfills the requirements stated in [PROMPT.md](PROMPT.md).

## Ruby version
A `.ruby-version` file exists to be used with `rbenv` and `rvm`. If you are not using ruby version management then check the `.ruby-version` file for the version required for this repo.

## Setup
```sh
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Run
```sh
rails s
curl localhost:3000/borrowers
curl localhost:3000/invoices
```

## Test
```sh
rails test
```

The most important thing in this application to test is the fee accrual. There is a method in [app/models/invoice.rb](app/models/invoice.rb) that calcuates the accrued fees. There are a few tests in [test/models/invoice_test.rb](app/models/invoice.rb) to test this calculation.

Additionally I didn't write any state transition tests because AASM is a well tested state machine library. Testing this would cost time for little benefit. Similarly, I saw little reason to test the Borrower model because it does nothing. 

Because the controllers are simple, I opted not to create a set of tests for the controllers. If the controllers were more complex, I would suggest we move the complexity from the controller to a service. Let the service loosely couple the model to the controller, and then test the service.

An integration test for testing uploads is critical. That is a high prioirity to-do item. There is a stub with some example code to get started in [test/integration/api.rb](test/integration/api.rb).

There are a lot of `TODO:` statements around this project. There are lots of places where features could be improved, obvious bugs exist that could be fixed, and testing is lacking. With time these issues could all be addressed, and I have only called out some of them.