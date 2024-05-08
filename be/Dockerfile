FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev default-mysql-client vim

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
