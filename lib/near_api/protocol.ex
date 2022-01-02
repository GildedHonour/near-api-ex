defmodule NearApi.Protocol do
  @moduledoc """
  NEAR RPC - Protocol API
  """
  import NearApi.Utils, only: [api_call_method: 2]

  @doc """
  Returns current genesis configuration.
  """
  @spec genesis_config() :: {:ok, body :: map} | NearApi.Errors.t()
  def genesis_config(), do: api_call_method(nil, "EXPERIMENTAL_genesis_config")

  @doc """
  Returns most recent protocol configuration or a specific queried block.
  Useful for finding current storage and transaction costs.
  """
  @spec protocol_config(block_id :: any, finality :: String.t()) :: {:ok, body :: map} | NearApi.Errors.t()
  def protocol_config(block_id \\ nil, finality \\ "final"), do: api_call_method(nil, "EXPERIMENTAL_protocol_config")
end
