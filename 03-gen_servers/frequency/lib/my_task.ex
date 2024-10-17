defmodule MyTask do
  use Task
  
  def start_link(args), do: Task.start_link(__MODULE__, :run, args)

  def run(args) do
    # do stuff hereq
  end
end
