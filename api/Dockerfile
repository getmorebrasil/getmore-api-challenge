FROM elixir:1.12-alpine AS builder

RUN apk add --no-cache build-base

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY . .
RUN mix do deps.get, deps.compile, release --overwrite

FROM alpine:3.13.3

RUN apk add --update --no-cache \
    curl curl-dev make g++ postgresql-client bash openssh git openssl libgcc ncurses-libs

WORKDIR /app


COPY --from=builder /app/_build/prod/rel/api ./

ENV HOME=/app

CMD ["bin/api", "start"]
