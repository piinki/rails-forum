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
COPY . .

FROM baseenv as buildasset
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update && apt-get install yarn \
      && rake assets:precompile

FROM buildasset as webserver
COPY --from=buildasset /myapp/public/assets/* ./public/assets/
