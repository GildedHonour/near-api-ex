defmodule NearApi do
  @moduledoc """
  NEAR RPC API
  """

  defdelegate view_access_key(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.AccessKeys

  defdelegate view_access_key_list(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.AccessKeys
end
