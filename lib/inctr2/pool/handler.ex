defmodule Inctr2.Pool.Handler do
  use DynamicSupervisor

  alias Inctr2.Pool.Worker

  def add_children(pool_size \\ 10) do
    Enum.map(1..pool_size, fn _ ->
      DynamicSupervisor.start_child(__MODULE__, {Worker, []})
    end)
  end

  def sleepy_echo(time) do
    children = DynamicSupervisor.which_children(__MODULE__)

    if Enum.empty?(children) do
      add_children()

      sleepy_echo(time)
    else
      [{_, pid, _, _}] =
        children
        |> Enum.shuffle()
        |> Enum.take(1)

      Worker.echo_sleep(pid, time)
    end
  end

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
