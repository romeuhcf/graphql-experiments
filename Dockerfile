FROM ruby:2.6.3-alpine
RUN apk --upgrade --no-cache add build-base  postgresql-dev nodejs tzdata
RUN mkdir /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle install -j 6
COPY . .
# Add a script to be executed every time the container starts.
ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
