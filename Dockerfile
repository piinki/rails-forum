# FROM | Image duoc build tu image Ruby 2.5.1

FROM ruby:2.5.1 AS baseenv

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && apt-get install -y \
      build-essential mysql-client libv8-dev nodejs\
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

# Tao thu muc
RUN mkdir /myapp

# Chi dinh thu muc lam viec
WORKDIR /myapp

COPY Gemfile* ./
RUN bundle install

COPY . /myapp

FROM baseenv as buildasset
RUN bundle exec rake assets:precompile && assets:clean

FROM buildasset as webserver
COPY --from=buildasset /myapp/public/assets/* ./public/assets
