FROM ruby:3.1.2

ENV APP_USER=xfs

RUN apt-get update -y
RUN apt-get install bash -y

ADD . /cli
WORKDIR /cli

# Install & run bundler
RUN gem install bundler:2.2.32
RUN gem install rake

CMD bundle install
