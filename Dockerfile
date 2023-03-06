FROM ruby:3.1.2-alpine


RUN apk add --no-cache \
  build-base \
  sqlite-dev \
  tzdata \
  nodejs \
  yarn \
  git


WORKDIR /app


COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && bundle install --jobs 20 --retry 5


COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
