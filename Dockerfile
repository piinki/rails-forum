# FROM | Image duoc build tu image Ruby 2.5.1

FROM ruby:2.5.1


ARG MYSQL_HOST=localhost
ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_HOST=$MYSQL_HOST
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
# RUN | Chay lenh khi build image
# Cac package can thiet

RUN apt-get update -qq && apt-get install -y \
      build-essential mysql-client libv8-dev \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

# Tao thu muc

RUN mkdir /myapp

# Chi dinh thu muc lam viec

WORKDIR /myapp


COPY Gemfile* ./
RUN bundle install

COPY . /myapp
COPY /myapp/application.yml.sample /myapp/application.yml

EXPOSE 3000
