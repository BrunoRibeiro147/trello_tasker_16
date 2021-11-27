defmodule TrelloTasker16.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TrelloTasker16.Repo,
      # Start the Telemetry supervisor
      TrelloTasker16Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TrelloTasker16.PubSub},
      # Start the Endpoint (http/https)
      TrelloTasker16Web.Endpoint,
      TrelloTasker16.Shared.Providers.CacheProvider.CardCache

      # Start a worker by calling: TrelloTasker16.Worker.start_link(arg)
      # {TrelloTasker16.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TrelloTasker16.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrelloTasker16Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
