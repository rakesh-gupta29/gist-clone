defmodule Tools.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ToolsWeb.Telemetry,
      Tools.Repo,
      {DNSCluster, query: Application.get_env(:tools, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tools.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tools.Finch},
      # Start a worker by calling: Tools.Worker.start_link(arg)
      # {Tools.Worker, arg},
      # Start to serve requests, typically the last entry
      ToolsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tools.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ToolsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
