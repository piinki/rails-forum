# FROM | Image duoc build tu image Ruby 2.5.1

FROM ruby:2.5.1


ARG MYSQL_HOST
ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_HOST=$MYSQL_HOST
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
# RUN | Chay lenh khi build image
# Cac package can thiet
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
EXPOSE 3000

RUN if [ "$RAILS_ENV" = 'production' ]; then bundle exec rake assets:precompile assets:clean ; fi
