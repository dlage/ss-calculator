FROM ruby:3.4.11-slim-bookworm
COPY --from=node:22-bookworm-slim /usr/local/ /usr/local/
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev libicu-dev zlib1g-dev pkg-config git ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /myapp
COPY Gemfile Gemfile.lock package.json package-lock.json ./
RUN bundle install && npm ci
COPY . .
RUN npm run build && npm run build:css
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
