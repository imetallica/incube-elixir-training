defmodule Inctr2.Yolo2 do
  use GenServer
  require Logger

  def crash_me do
    GenServer.cast(__MODULE__, :crash)
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    Logger.debug("#{inspect(__MODULE__)}: #{inspect(args)}")

    {:ok, %{}}
  end
end
