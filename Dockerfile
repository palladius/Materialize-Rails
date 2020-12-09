# Dockerfile
# Use ruby image to build our own image
# Dato che ci metto UNA VITA considera usare l'altro dockerillo che fai molto prima per vedere se va..
# E se non va almeno ci metti 3 secondi, se invece va poi sostituisici Dockerfile.superquick con Dockerfile
FROM ruby:2.7

ENV APP_HOME /app

# Added for YARN or it wont work...
# https://medium.com/@yuliaoletskaya/how-to-start-your-rails-app-in-a-docker-container-9f9ce29ff6d6

RUN apt-get update
RUN apt-get install -y \
  curl \
  build-essential \
  libmariadb-dev \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

# We specify everything will happen within the /app folder inside the container
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#########################################################################
# 1. We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock ./

RUN bundle update --bundler
# We install all the dependencies
RUN bundle install

# From Yulia, make yarn work
COPY package.json .
COPY yarn.lock .
#RUN yarn install

# We copy all the files from our current application to the /app container
COPY . .

RUN yarn install --check-files
#RUN rake yarn:install # inutile a sto punto
#RUN rake assets:precompile

# We expose the port
#EXPOSE 3000
EXPOSE 8080
# Start the main process: $ rails server -b 0.0.0.0
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["./entrypoint-8080.sh"]
