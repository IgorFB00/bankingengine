defmodule BankingengineWeb.AccountController do
  @moduledoc """
  Actions related to the account resource.
  """
  use BankingengineWeb, :controller

  alias Bankingengine.Accounts
  alias BankingengineWeb.InputValidation
  alias Bankingengine.Accounts.Inputs

  def show(conn, %{"id" => account_id}) do
    # validates if account_id is a uuid. TODO: better validation
    with {:uuid, {:ok, _}} <- {:uuid, Ecto.UUID.cast(account_id)},
         {:ok, account} <- Accounts.fetch(account_id) do
      send_json(conn, 200, account)
    end
  else
    {:uuid, :error} ->
      send_json(conn, 404, %{type: "bad_input", description: "Not a UUID"})

    {:error, :not_found} ->
      send_json(conn, 404, %{type: "not_found", description: "Account not found"})
  end

  def transfer(conn, %{"from" => from, "to" => to, "value" => value}) do
    # verify balance
    with {:ok, from_acc} <- Accounts.fetch(from),
         {:ok, to_acc} <- Accounts.fetch(to),
         from_preload <- Accounts.preload(from_acc),
         to_preload <- Accounts.preload(to_acc),
         from_changeset <-
           Inputs.EnoughBalance.changeset(
             from_preload,
             %{balance: from_preload.balance - value}
           ),
         to_changeset <-
           Inputs.EnoughBalance.changeset(
             to_preload,
             %{balance: to_preload.balance + value}
           ),
         {:ok, f, t} <- Accounts.transfer(from_changeset, to_changeset) do
      send_json(conn, 200, %{from: f, to: t})
    else
      {:error, _} ->
        msg = %{type: "error", description: "some error"}
        send_json(conn, 400, msg)
    end

    # with {:ok, from_changeset} <-
    #        InputValidation.cast_and_apply(
    #          %{account: from, value: value, tag: :withdraw},
    #          Inputs.EnoughBalance
    #        ),
    #      {:ok, to_changeset} <-
    #        InputValidation.cast_and_apply(
    #          %{account: to, value: value, tag: :add},
    #          Inputs.EnoughBalance
    #        ),
    #      {:ok, from, to} <- Accounts.transfer(from_changeset, to_changeset) do
    #   send_json(conn, 200, %{from: from, to: to})
    # else
    #   {:error, _} ->
    #     msg = %{type: "error", description: "some error"}
    #     send_json(conn, 400, msg)
    # end
  end

  def create(conn, params) do
    with {:ok, input} <- InputValidation.cast_and_apply(params, Inputs.Create),
         {:ok, account} <- Accounts.insert_new_account(input) do
      send_json(conn, 200, account)
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
