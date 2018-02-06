defmodule Inctr2.Yolo1 do
  use GenServer
  require Logger

  def push(what) do
    GenServer.cast(__MODULE__, {:push, what})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    Logger.debug("#{inspect(__MODULE__)}: #{inspect(args)}")

    {:ok, []}
  end

  def handle_call(:pop, _from, state) do
    Logger.debug("#{inspect(__MODULE__)}: Current state: #{inspect state}")
    
    if Enum.empty?(state) do
      {:reply, nil, state}
    else
      {:reply, hd(state), tl(state)}
    end
  end

  def handle_cast({:push, elem}, state) do
    new_state = state ++ [elem]

    {:noreply, new_state}
  end
end