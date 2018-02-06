defmodule Inctr2.Processing.Prod do
  use GenStage
  require Logger

  def start_link(args) do
    GenStage.start_link(__MODULE__, args, name: {:global, __MODULE__})
  end

  def sync_notify(event, timeout \\ 5000) do
    GenStage.call({:global, __MODULE__}, {:notify, event}, timeout)
  end

  def init(_args) do
    Logger.debug("#{inspect __MODULE__}")
    # BroadcastDispatcher, PartitionDispatcher, DemandDispatcher
    {:producer, :ok, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_call({:notify, event}, _from, state) do
    {:reply, :ok, [event], state} # Dispatch immediately
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state} # We don't care about the demand
  end
end