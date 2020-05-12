defmodule SendinblueTest do
  use ExUnit.Case
  import Mox

  test "create contact" do
    Sendinblue.HttpClientMockImpl
    |> expect(:post, fn _, _, _ ->
      {:ok,
       %HTTPoison.Response{
         body: "{\"id\":2}",
         headers: [],
         request: %HTTPoison.Request{
           body: "{\"email\":\"steffel1@nash.io\"}",
           headers: [
             {"Accept", "application/json"},
             {"content-type", "application/json"},
             {"api-key", "api key"}
           ],
           method: :post,
           options: [],
           params: %{},
           url: "https://api.sendinblue.com/v3/contacts"
         },
         request_url: "https://api.sendinblue.com/v3/contacts",
         status_code: 201
       }}
    end)

    assert {:ok, %{}} = Sendinblue.create_a_contact(%{})
  end

  test "update contact" do
    Sendinblue.HttpClientMockImpl
    |> expect(:put, fn _, _, _ ->
      {:ok,
       %HTTPoison.Response{
         body: "",
         headers: [],
         request: %HTTPoison.Request{
           body: "{\"attributes\":{\"email\":\"steffel.feni@nash.io\"}}",
           headers: [
             {"Accept", "application/json"},
             {"content-type", "application/json"},
             {"api-key", "api key"}
           ],
           method: :put,
           options: [],
           params: %{},
           url: "https://api.sendinblue.com/v3/contacts/steffel.fenix@nash.io"
         },
         request_url: "https://api.sendinblue.com/v3/contacts/steffel.fenix@nash.io",
         status_code: 204
       }}
    end)

    assert {:ok, %{}} = Sendinblue.update_a_contact("email@email.com", %{})
  end
end
