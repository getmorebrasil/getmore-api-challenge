[
  main: "readme",
  extras: [
    "README.md"
  ],
  groups_for_modules: [
    Authentication: [
      MarketWeb.Endpoint.Authentication,
      MarketWeb.Endpoint.Context
    ],
    GraphQL: [
      MarketWeb.Schema,
      MarketWeb.Schema.Bottler,
      MarketWeb.Schema.Session,
      MarketWeb.Schema.User,
      MarketWeb.Resolver.Bottler,
      MarketWeb.Resolver.Session,
      MarketWeb.Resolver.Utils,
      MarketWeb.UserSocket,
    ],
    Database: [
      Market.Repo,
      Market.Accounts,
      Market.Accounts.User,
      Market.Bottlers,
      Market.Bottlers.Provider,
      Market.Bottlers.Pair,
      Market.Bottlers.Bottler
    ],
    Phoenix: [
      Market,
      Market.Application,
      MarketWeb,
      MarketWeb.Endpoint,
      MarketWeb.Router,
      MarketWeb.Router.Helpers,
      MarketWeb.Gettext,
      MarketWeb.ErrorView,
      MarketWeb.ErrorHelpers
    ],
  ]
]
