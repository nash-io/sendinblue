defmodule Sendinblue.DefaultImpl do
  @moduledoc false
  require Logger
  @base_url "https://api.sendinblue.com"
  @spec create_a_contact(map) :: {:error, :api | :jason} | {:ok, any}
  def create_a_contact(params) do
    body = Jason.encode!(params)

    "#{@base_url}/v3/contacts"
    |> HttpClient.post(body, headers())
    |> parse_response()
  end

  @spec update_a_contact(binary(), map) :: {:error, :api | :jason} | {:ok, any}
  def update_a_contact(email, params) do
    body = Jason.encode!(params)

    "#{@base_url}/v3/contacts/#{email}"
    |> HttpClient.put(body, headers())
    |> parse_response()
  end

  defp parse_response(data) do
    with {:ok, %{body: body, status_code: status_code}} when status_code in [200, 201, 204] <-
           data,
         {:ok, response} <- decode(body) do
      {:ok, response}
    else
      {:ok, _} ->
        {:error, :api}

      {:error, body = %Jason.DecodeError{}} ->
        Logger.warn("could not decode body: #{inspect(body)}")
        {:error, :jason}

      {:error, response} ->
        Logger.warn(inspect(response))
        {:error, :api}
    end
  end

  def decode(""), do: {:ok, %{}}
  def decode(body), do: Jason.decode(body)

  defp headers() do
    [
      {"Accept", "application/json"},
      {"content-type", "application/json"},
      {"api-key", api_key()}
    ]
  end

  defp api_key,
    do: Application.get_env(:sendinblue, :api_key) || System.get_env("SENDINBLUE_API_KEY")
end
