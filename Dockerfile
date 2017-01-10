FROM ruby:2.3.3

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update -qq
RUN apt-get install -y \
  build-essential \
  nodejs \
  libpq-dev \
  mysql-client

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir /myapp
# VOLUME ["/myapp"]
WORKDIR /myapp

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY ./example-rails-app/Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Link the main application folder
ENV app /app
RUN mkdir $app
WORKDIR $app
ADD ./example-rails-app $app

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Try to do a db:create, db:migrate, db:seed (if database doesn't exist) WIP
RUN echo "Please migrate your db"

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
