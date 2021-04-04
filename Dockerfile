FROM ruby:3.0.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
  
RUN mkdir /nayami2
WORKDIR /nayami2

ADD Gemfile /nayami2/Gemfile
ADD Gemfile.lock /nayami2/Gemfile.lock

ENV BUNDLER_VERSION 2.2.11
RUN gem install bundler
RUN bundle install

ADD . /nayami2
