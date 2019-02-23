FROM ruby:2.4.2
ADD . /code
WORKDIR /code
RUN gem install bundler
RUN bundle 
RUN bundle exec rake db:reset
CMD bundle exec rails runner script/stats.rb
