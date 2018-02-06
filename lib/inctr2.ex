defmodule Inctr2 do
  use Application

  def start(_type, _args) do
    children = [
      {Inctr2.Sup, [:yolo]},
      {Inctr2.Pool.Handler, []},
      {Inctr2.Processing.Prod, []}
    ]

    # Top supervisor
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
