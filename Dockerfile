FROM ruby:3.3.4
WORKDIR /app

COPY ./bin /app/
COPY .env /app/
COPY .env /app/
COPY Gemfile /app/ 
COPY Gemfile.lock /app/  

RUN bundle install
