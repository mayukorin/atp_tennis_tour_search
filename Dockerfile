# syntax=docker/dockerfile:1
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn && apt-get install -y npm
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs
RUN apt-get install -y cron
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]