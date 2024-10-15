defmodule Frequency do
  use GenServer

  @impl true
  def init(_args) do
    frequencies = [1, 2, 3, 4]
    {:ok, {frequencies, []}}
  end

  @impl true
  def handle_call(:allocate, from, state) do
    {pid, _tag} = from
    {new_state, reply} = allocate(state, pid)
    {:reply, reply, new_state}
  end

  def handle_call({:deallocate, freq}, _from, state) do
    {new_state, reply} = deallocate(state, freq)
    {:reply, reply, new_state}
  end

  defp allocate({[], _}, _pid), do: {[], {:error, :no_frequencies}}

  defp allocate({[freq | frequencies], allocated}, pid) do
    {{frequencies, [{freq, pid} | allocated]}, {:ok, freq}}
  end

  defp deallocate({frequencies, allocated}, freq) do
    allocated = List.keydelete(allocated, freq, 0)
    {{[freq | frequencies], allocated}, :ok}
  end
end
