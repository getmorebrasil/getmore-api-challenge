FROM elixir:1.11.2

# create app folder
RUN mkdir /app
COPY . /app
WORKDIR /app

# install mix dependencies
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

CMD ["mix", "run"]