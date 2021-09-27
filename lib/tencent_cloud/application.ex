defmodule TencentCloud.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    finch_pool = Application.get_env(:tencent_cloud, :finch_pool, size: 32, count: 8)

    children = [
      {Finch, name: TencentCloud.Finch, pools: %{:default => finch_pool}}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TencentCloud.Supervisor)
  end
end
