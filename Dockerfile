FROM ruby:2.7.2

RUN apk add --update --virtual \
    runtime-deps \
    postgresql-client \
    nodejs \
    yarn \
    && rm -rf /var/cache/apk/*

WORKDIR /smartflix
COPY . /smartflix/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000
