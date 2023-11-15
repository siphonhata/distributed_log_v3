# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :distributed_log_v3,
  ecto_repos: [DistributedLogV3.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :distributed_log_v3, DistributedLogV3Web.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: DistributedLogV3Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: DistributedLogV3.PubSub,
  live_view: [signing_salt: "ZvbhaoTl"]

# Configures Elixir's Logger
config :logger, backends: [ExLogger]

config :logger, :console,
  format: "$time [$level] $message $metadata\n",
  metadata: :all,
  metadata_filter: [:time]

config :logger, ExLogger,
  level: :debug,
  sink_node: :"logsink@localhost",
  format: "$time [$level] $message $metadata\n"


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
