defmodule MyApp.Worker3 do
  @moduledoc """
  Third worker for the supervisor
  """
  use GenServer
  @step 3

  def start_link(_init_args), do: GenServer.start(__MODULE__, 0, name: __MODULE__)

  def value, do: GenServer.call(__MODULE__, :get_value)

  @impl true
  def init(initial_value) do
    {:ok, initial_value, {:continue, :work}}
  end

  @impl true
  def handle_continue(:work, state) do
    Process.send_after(__MODULE__, :work, 1000)
    {:noreply, state}
  end

  @impl true
  def handle_call(:get_value, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:work, state) do
    new_state = state + @step
    Process.send_after(__MODULE__, :work, 1000)
    {:noreply, new_state}
  end
end
