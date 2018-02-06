defmodule Inctr2.Pool.Worker do
  use GenServer
  require Logger
  
  def echo_sleep(pid, time) do
    GenServer.call(pid, {:echo, time})
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args) do
    Logger.debug("#{inspect(__MODULE__)} | #{inspect(self())}")

    {:ok, []}
  end

  def handle_call({:echo, time}, _from, state) do
    Logger.debug("#{inspect(__MODULE__)} | #{inspect(self())}: Sleeping for: #{inspect time}. Current state: #{inspect state}")

    Process.sleep(time)
    
    {:reply, time, state}
  end

  def handle_cast({:push, elem}, state) do
    new_state = state ++ [elem]

    {:noreply, new_state}
  end
end