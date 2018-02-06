defmodule Inctr2 do
  use Application

  @doc """
  Initialize with `iex --name "name@YOUR-IP" -S mix`.
  """
  def start(_type, _args) do
    :erlang.set_cookie(node(), Incube600MA)

    children = [
      {Inctr2.Sup, [:yolo]},
      {Inctr2.Pool.Handler, []},
      {Inctr2.Processing.Prod, []},
      Supervisor.child_spec({Inctr2.Processing.Con, []}, id: PCon1),
      Supervisor.child_spec({Inctr2.Processing.Con, []}, id: PCon2),
      Supervisor.child_spec({Inctr2.Processing.Con, []}, id: PCon3),
      Supervisor.child_spec({Inctr2.Processing.Con, []}, id: PCon4),
      Supervisor.child_spec({Inctr2.Processing.Con, []}, id: PCon5),
    ]

    # Top supervisor
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
