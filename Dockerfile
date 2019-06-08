FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y --no-install-recommends cron && \
  rm -rf /var/lib/apt/lists/* \
  nodejs postgresql-client vim
ENV RAILS_ENV development
RUN mkdir /quotation-hunter
WORKDIR /quotation-hunter
COPY Gemfile /quotation-hunter/Gemfile
COPY Gemfile.lock /quotation-hunter/Gemfile.lock
COPY . /quotation-hunter
RUN bundle install
RUN bundle exec whenever --update-crontab
CMD cron -f && bundle exec puma


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]