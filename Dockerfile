# FROM | Image duoc build tu image Ruby 2.5.1

FROM ruby:2.5.6 AS baseenv

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && apt-get install -y \
      build-essential default-mysql-client libv8-dev nodejs\
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

# Tao thu muc
RUN mkdir /myapp

# Chi dinh thu muc lam viec
WORKDIR /myapp

COPY Gemfile* ./
RUN bundle install --without development test
RUN cat Gemfile.lock

COPY . .

FROM baseenv as buildasset
RUN yarn install && rake assets:precompile

FROM buildasset as webserver
COPY --from=buildasset /myapp/public/assets/* ./public/assets/
