defmodule Inctr2.Processing.Con do
  use GenStage
  require Logger

  def start_link(args) do
    GenStage.start_link(__MODULE__, args)
  end

  def init(_args) do
    Logger.debug("#{inspect __MODULE__} | #{inspect self()}: Initializing")
    {:consumer, :whatever, subscribe_to: [{{:global, Inctr2.Processing.Prod}, max_demand: 5}]}
  end

  def handle_events(events, _from, state) do
    Logger.info("#{inspect __MODULE__} | #{inspect self()}: Handling #{inspect events}.")

    Process.sleep(1_000)

    {:noreply, [], state}
  end

end
