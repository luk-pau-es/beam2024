defmodule Eco.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DNSCluster, query: Application.get_env(:eco, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Eco.PubSub}
      # Start a worker by calling: Eco.Worker.start_link(arg)
      # {Eco.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Eco.Supervisor)
  end
end
