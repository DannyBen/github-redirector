FROM dannyben/alpine-ruby

COPY Gemfile* ./
RUN gem install bundler && \
    bundle config set without 'development test' && \
    bundle install --jobs=3 --retry=3

WORKDIR /app
COPY . .
RUN chmod +x /app/server.rb

EXPOSE 3000
ENTRYPOINT ["/app/server.rb"]
