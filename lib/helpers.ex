defmodule NearApi.Helpers do
  @moduledoc """
  NEAR API Utils module;
  Note: Draft version, will be refactored
  """
  alias NearApi.RPC.Errors

  @doc """
  Does the actual RPC call to the NEAR API and formats output
  """
  def api_call(payload) do
    payload
    |> NearApi.HttpClient.api_call_method("query")
    |> process_api_response()
  end

  @doc """
  Does the actual RPC call to the NEAR API and formats output
  Usually used for experimental calls
  """
  def api_call_method(payload, method) do
    response = NearApi.HttpClient.api_call_method(payload, method)

    process_api_response(response)
  end

  @doc """
  Public Key retriever. :woof
  """
  def public_key do
    System.get_env("NEAR_PUBLIC_KEY")
  end

  # SOFT_ERROR - this is our error type when API weirdly returns you status_code: 200 but this is an error message
  defp process_api_response(response) do
    case response do
      %{"result" => %{"error" => error_message}} = response ->
        {:error, %{response: response, error_message: error_message, error_type: "SOFT_ERROR"}}

      %{"error" => _error} = response ->
        Errors.render_error(response)

      body ->
        {:ok, body}
    end
  end

  defmodule Monetary do
    require Integer

    @doc """
    Convert NEAR amount into Yocto amount
    """
    @spec near_to_yocto(near :: integer | float) :: integer
    def near_to_yocto(near) do
      near * pow(10, 24)
    end

    def pow(_, 0), do: 1
    def pow(x, n) when Integer.is_odd(n), do: x * pow(x, n - 1)

    def pow(x, n) do
      result = pow(x, div(n, 2))
      result * result
    end
  end
end
