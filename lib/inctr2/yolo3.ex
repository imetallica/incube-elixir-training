defmodule Inctr2.Yolo3 do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    Logger.debug("#{inspect __MODULE__}: #{inspect args}")

    {:ok, %{}}
  end
end