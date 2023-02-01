# syntax=docker/dockerfile:1
FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn --no-install-recommends -y
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY package.json /myapp/
RUN gem install bundler -v 2.1.2
RUN bundle install
COPY yarn.lock /myapp/
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]