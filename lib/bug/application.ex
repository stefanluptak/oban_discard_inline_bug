defmodule Bug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bug.Repo,
      # Start the Telemetry supervisor
      {Oban, oban_config()},
      BugWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bug.PubSub},
      # Start the Endpoint (http/https)
      BugWeb.Endpoint
      # Start a worker by calling: Bug.Worker.start_link(arg)
      # {Bug.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BugWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.fetch_env!(:bug, Oban)
  end
end
