defmodule Frequency do
  @frequencies [10, 11, 12, 13, 14, 15]

  def start(), do: Process.register(spawn(Frequency, :init, []), Frequency)
  def init(), do: loop({@frequencies, []})
  def stop(), do: call(:stop)
  def allocate(), do: call(:allocate)
  def deallocate(freq), do: call({:deallocate, freq})

  def call(message) do
    send(Frequency, {:request, self(), message})

    receive do
      {:ok, reply} -> reply
      {:error, error} -> {:error, error}
    end
  end

  def loop(frequencies) do
    receive do
      {:request, pid, :allocate} ->
        {frequencies, reply} = allocate(frequencies, pid)
        send(pid, reply)
        loop(frequencies)

      {:request, pid, {:deallocate, freq}} ->
        {frequencies, reply} =
          deallocate(frequencies, freq)

        send(pid, reply)
        loop(frequencies)

      {:request, pid, :stop} ->
        Process.exit(pid, :ok)
    end
  end

  def allocate({[], _} = frequencies, _pid) do
    {frequencies, {:error, :no_frequencies}}
  end

  def allocate({[freq | frequencies], allocated}, pid) do
    allocated = [{freq, pid} | allocated]
    {{frequencies, allocated}, {:ok, freq}}
  end

  def deallocate({frequencies, allocated}, freq) do
    allocated = List.keydelete(allocated, freq, 0)
    {[freq | frequencies], {:ok, allocated}}
  end
end
