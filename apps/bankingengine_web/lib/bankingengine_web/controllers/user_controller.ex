defmodule BankingengineWeb.UserController do
  @moduledoc """
  Actions related to the user resource.
  """
  use BankingengineWeb, :controller

  alias Bankingengine.Users
  alias BankingengineWeb.InputValidation
  alias Bankingengine.Users.Inputs

  def create(conn, params) do
    with {:ok, input} <- InputValidation.cast_and_apply(params, Inputs.Create),
         {:ok, user} <- Users.insert_new_user(input) do
      send_json(conn, 200, user)
    else
      {:error, :unique_field_taken} ->
        msg = %{type: "conflict", description: "Any unique field taken"}
        send_json(conn, 412, msg)

      {:error, changeset} ->
        # TODO, PUT IN THE DESCRIPTION THE APPROPRIATE ERROR FROM CHANGESET
        msg = %{type: "bad_request", description: "Your request had bad data"}
        send_json(conn, 400, msg)
    end
  end

  defp send_json(conn, status, body) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
