defmodule MyApp.WorkerSupervisor do
  @moduledoc """
  Worker Supervisor
  """
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    # fix typo
    childer = [
      # {MyApp.Worker1, []},
      # {MyApp.Worker2, []},
      # {MyApp.Worker3, []}
    ]

    Supervisor.init(childer, strategy: :one_for_one)
  end
end
