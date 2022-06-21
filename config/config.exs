# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bug,
  ecto_repos: [Bug.Repo]

# Configures the endpoint
config :bug, BugWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BugWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Bug.PubSub,
  live_view: [signing_salt: "vbhN2/Dz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bug, Oban,
  repo: Bug.Repo,
  plugins: [
    # 3 days
    {Oban.Plugins.Pruner, max_age: 3 * 24 * 60 * 60},
    Oban.Plugins.Gossip
  ],
  queues: [
    default: 1
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
