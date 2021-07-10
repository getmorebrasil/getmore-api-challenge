FROM elixir:1.12-alpine AS builder

RUN apk add --no-cache build-base

WORKDIR /app

RUN mix local.rebar --force && \
    mix local.hex --force

ENV MIX_ENV=prod

COPY . .
RUN mix do deps.get, deps.compile, release --overwrite

FROM alpine:3.13.3

RUN apk add --update --no-cache \
    curl curl-dev make g++ postgresql-client bash openssh git openssl libgcc

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/products ./

ENV HOME=/app

ENTRYPOINT ["bin/products", "start"]