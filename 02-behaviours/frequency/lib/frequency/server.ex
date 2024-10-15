defmodule Server do
  defmacro __using__(_) do
    quote do
      @behaviour Server
      @impl Server
      def handle(_message, state) do
        {state, {:error, :no_implemented}}
      end

      defoverridable handle: 2
    end
  end

  @callback init([term]) :: {list(), list()}
  @callback handle(term, term) :: {term, term}

  def start(module, args) do
    pid = spawn(__MODULE__, :init, [module, args])
    Process.register(pid, module)
    {:ok, pid}
  end

  def stop(pid), do: send(pid, :stop)

  def init(module, args) do
    state = apply(module, :init, [args])
    loop(module, state)
  end

  def loop(module, state) do
    receive do
      {:request, pid, message} ->
        {state, reply} = apply(module, :handle, [message, state])
        Process.send(pid, reply, [])
        loop(module, state)

      :stop ->
        :ok
    end
  end

  def call(pid, message) do
    send(pid, {:request, self(), message})

    receive do
      {:ok, reply} -> {:ok, reply}
      {:error, error} -> {:error, error}
    end
  end
end
