defmodule Sendinblue do
  @moduledoc """
  Documentation for `Sendinblue`.


  ## Get started


  In your configuration file, add your API key.

  ```
  config :sendinblue, :api_key, "API KEY HERE"
  ```

  """
  def create_a_contact(params) do
    impl().create_a_contact(params)
  end

  def update_a_contact(email, params) do
    impl().update_a_contact(email, params)
  end

  def impl, do: Application.get_env(:sendinblue, :impl, Sendinblue.DefaultImpl)
end
