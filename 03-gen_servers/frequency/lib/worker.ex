defmodule Worker do
  use GenServer
  # GenServer.call(Worker, ..)

  @gen_server
  defmodule Client do
    %{"data" => %{.....qq}}
    def insert(data), do: GenServer.call(__MODULE__, {:insert, data})
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    :ets.new(:redis, [:private, :bag, :named_table])
    {:ok, [], {:continue, :work}}
  end

  # state == []
  @impl true
  def handle_continue(:work, state) do
    :ets.insert(:redis, {:chris, :irleand, :cook})
    :ets.insert(:redis, {:alic, :belgium, :tester})

    {:noreply, state}
  end

  @impl true
  def handle_call({:insert, data}, _from, state) do
    :ets.insert(:redis, data)
    {:reply, :ok, state}
  end

  @impl true
  def handle_cast({:delete, name}, state) do
    :ets.delete(:redis, name)
    {:noreply, state}
  end
end
