FROM dannyben/alpine-ruby

COPY Gemfile* ./
RUN gem install bundler && bundle install --jobs=3 --retry=3 

WORKDIR /app
COPY . .

EXPOSE 3000
ENTRYPOINT ["/app/server.rb"]
