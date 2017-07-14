# Contact Trace

Development challenge of an application, using an api rest to store browsing history of websites.

## Pre-requisites

* Ruby 2.4.0
* Rails 5.1.2
* SQlite or Postgresql
* Make

Using Makefile to describe the possible tasks used in development.

## Setup 

Clone the repository in a local folder.
```bash
$ git clone https://github.com/Zapelini/user_trace.git
$ cd user_trace_py
$ bundle install --without production
```

## Database

#### Create database
```bash
$ make db_create
```
#### Migrate database
```bash
$ make db_migrate:
```

## Running test

```bash
make test_unit
```

## Running app

```bash
make dev_run
```
Access your browser at http://localhost:3000.
