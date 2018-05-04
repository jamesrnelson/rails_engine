# Rails Engine

* An API exploration.
* This project uses Ruby on Rails and ActiveRecord to build a JSON API to share sanitized data from Etsy. This API serves business intelligence, relationship endpoints, and record endpoints.
* The spec for this project can be found here: [Project Spec](http://backend.turing.io/module3/projects/rails_engine)

## Getting Started

To run this application locally, clone this repo and follow the steps below:

Bundle:
`$ bundle`

Seed the database:
`$ rake db:create`
`$ rake db:migrate`
`$ rake import_all`

Start up your rails server with `rails s`
and open localhost:3000 in your browser. Visit any endpoint by typing into the address bar.

### Prerequisites

Ruby Version: 2.4+
Rails Version: 5+

## Running the tests

To run the test suite, run `rspec` from the root directory in your terminal.

## Built With

* [factorybot](https://github.com/thoughtbot/factory_bot)
* [database cleaner](https://github.com/DatabaseCleaner/database_cleaner)
* [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers)

## Authors
* [Margaret Williford](https://github.com/lilwillifo)
* [Jimmy Nelson](https://github.com/jamesrnelson)
