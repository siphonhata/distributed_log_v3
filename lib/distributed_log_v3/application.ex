defmodule DistributedLogV3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    children = [
      {ReporterState, 0},
      DistributedLogV3.PromEx,
      DistributedLogV3Web.Telemetry,
      DistributedLogV3.Repo,
      {DNSCluster, query: Application.get_env(:distributed_log_v3, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DistributedLogV3.PubSub},
      # Start a worker by calling: DistributedLogV3.Worker.start_link(arg)
      # {DistributedLogV3.Worker, arg},
      # Start to serve requests, typically the last entry
      DistributedLogV3Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedLogV3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DistributedLogV3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
