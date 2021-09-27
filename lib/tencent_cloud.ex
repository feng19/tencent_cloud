defmodule TencentCloud do
  @moduledoc """
  Call TencentCloud Services in Elixir

  全局配置 AK :

      config :tencent_cloud,
        access_key_id: "your_key",
        access_key_secret: "your_secret"

  调用时提供:

      call(
        %{
          host: "nlp.tencentcloudapi.com",
          action: "ChatBot",
          version: "2019-04-08",
          region: "ap-guangzhou",
          access_key_id: "your_key",
          access_key_secret: "your_secret"
        },
        %{"Query" => "hello"}
      )
  """

  alias TencentCloud.Core

  @doc """
  调用 TencentCloud 服务

  ## Example

      call(
        %{
          host: "nlp.tencentcloudapi.com",
          action: "ChatBot",
          version: "2019-04-08",
          region: "ap-guangzhou"
        },
        %{"Query" => "hello"}
      )
  """
  @spec call(common :: map, data :: Enumerable.t()) :: Tesla.Env.result()
  def call(common, data) do
    call(common, data, [
      Tesla.Middleware.Logger,
      Tesla.Middleware.Retry,
      {Tesla.Middleware.Timeout, timeout: 30_000},
      Tesla.Middleware.DecodeJson
    ])
  end

  @spec call(common :: map, data :: Enumerable.t(), [Tesla.Client.middleware()]) ::
          Tesla.Env.result()
  def call(common, data, middlewares) do
    url = Map.get_lazy(common, :url, fn -> "https://" <> common.host end)
    body = Jason.encode!(data)

    headers =
      common
      |> Map.put_new_lazy(:access_key_id, fn ->
        Application.fetch_env!(:tencent_cloud, :access_key_id)
      end)
      |> Map.put_new_lazy(:access_key_secret, fn ->
        Application.fetch_env!(:tencent_cloud, :access_key_secret)
      end)
      |> Core.common_headers(body)

    Tesla.client(
      [{Tesla.Middleware.Headers, headers} | middlewares],
      {Tesla.Adapter.Finch, name: TencentCloud.Finch, pool_timeout: 5_000, receive_timeout: 5_000}
    )
    |> Tesla.post(url, body)
  end
end
