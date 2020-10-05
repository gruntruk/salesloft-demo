# README

This submission uses the following runtime dependencies:

* Ruby 2.7 + Bundler

* Node 12

* Rails 6

## Running the Sample

After bundling dependencies you must do the following:

1. Copy `.env.template` to the requisite `.env` file and update the SALESLOFT_API_KEY variable within with a working API key

1. Start the local server with `bin/foreman start`

1. Open your browser to `http://localhost:3000`

## Running the Test Suite

This sample includes both unit and system tests. To execute them you can do the following:

1. Run unit/integration tests with `bin/rails test`

1. Run system tests with `bin/rails test:system`
