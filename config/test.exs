import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :distributed_log_v3, DistributedLogV3.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "distributed_log_v3_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :distributed_log_v3, DistributedLogV3Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "o9SB0NI3q17idrQZkk1q0JLFJF72wPlu5zuPM13DRSBZ7iHN5Df7RV0Whgf0NLT6",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
