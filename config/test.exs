import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :trello_tasker_1_6, TrelloTasker16.Repo,
  username: "postgres",
  password: "postgres",
  database: "trello_tasker_1_6_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :trello_tasker_1_6, TrelloTasker16Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "TaOqtiF+8vsvfxrtqyc5qFyA2iOvpscB6Wd4MO6Z0XHPd3ZzewHct8MKv6j0EHFg",
  server: false

# In test we don't send emails.
config :trello_tasker_1_6, TrelloTasker16.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
