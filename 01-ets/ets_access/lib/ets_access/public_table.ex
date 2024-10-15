defmodule EtsAccess.PublicTable do
  @moduledoc """
  Module managing public ETS table.
  """
  use GenServer

  @impl true
  def init(_) do
    :ets.new(:public_table, [:public, :set, :named_table])
    :ets.insert(:public_table, {1, "public alice"})
    :ets.insert(:public_table, {2, "public bob"})
    {:ok, []}
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def list(table_name), do: GenServer.call(__MODULE__, {:list, table_name})
  def search(table_name, key), do: GenServer.call(__MODULE__, {:search, table_name, key})
  def insert(table_name, object), do: GenServer.call(__MODULE__, {:insert, table_name, object})

  @impl true
  def handle_call({:list, table_name}, _from, state) do
    {:reply, :ets.tab2list(table_name), state}
  end

  def handle_call({:search, table_name, key}, _from, state) do
    {:reply, :ets.lookup(table_name, key), state}
  end

  def handle_call({:insert, table_name, object}, _from, state) do
    {:reply, :ets.insert(table_name, object), state}
  end
end
