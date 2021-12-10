FROM ruby:3.0.3

ENV HOME /root

# NodeJS 16
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh

# Postgres 14
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -


RUN apt update && apt-get install -y --allow-unauthenticated libicu-dev \
                                                             libaio-dev \
                                                             libpq-dev \
                                                             postgresql-14 \
                                                             redis-tools \
                                                             nodejs \
                                                             vim \
                                                             htop

# TimeZone
ENV TZ=America/Sao_Paulo

# ENV RAILS_ENV=production

ADD . /home/noise_gate
WORKDIR /home/noise_gate

RUN npm i yarn --global

RUN gem install bundler rails pg
COPY Gemfile Gemfile
Copy Gemfile.lock Gemfile.lock

# RUN RAILS_ENV=production bundle exec rake assets:precompile
# RUN RAILS_ENV=development bundle exec rake assets:precompile

RUN bundle install
RUN yarn install

EXPOSE 8080
CMD rails server -b 0.0.0.0 -p 8080
