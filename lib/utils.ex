defmodule NearApi.Utils do
  @moduledoc """
  NEAR API Utils module
  """
  alias NearApi.Errors

  @doc """
  Does the actual RPC call to the NEAR API and formats output
  """
  def api_call(payload) do
    payload
    |> NearApi.HttpClient.api_call()
    |> process_api_response()
  end

  @doc """
  Does the actual RPC call to the NEAR API and formats output
  """
  def api_call_experimental(payload, method) do
    response = NearApi.HttpClient.api_call_experimental(payload, method)

    process_api_response(response)
  end

  @doc """
  Public Key retriever. :woof
  """
  def public_key do
    System.get_env("NEAR_PUBLIC_KEY")
  end

  defp process_api_response(response) do
    case response do
      %{"result" => %{"error" => error_message}} = response ->
        {:error, response: response, error_message: error_message}

      %{"error" => _error} = response ->
        Errors.render_error(response)

      body ->
        {:ok, body}
    end
  end
end
