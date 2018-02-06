defmodule Inctr2.Sup do
  use Supervisor
  require Logger

  alias Inctr2.{Yolo1, Yolo2, Yolo3}

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    Logger.debug("#{inspect(__MODULE__)}: #{inspect(args)}")

    children = [
      {Yolo1, ["foo1"]},
      {Yolo2, ["foo2"]},
      {Yolo3, ["foo3"]}
    ]

    # :one_for_all, :rest_for_one, :one_for_one
    Supervisor.init(children, strategy: :one_for_one)
  end
end
