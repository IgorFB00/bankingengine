defmodule Bankingengine.Accounts do
  @moduledoc """
  Domain public functions about the accounts context.
  """
  alias Bankingengine.Accounts.Inputs
  alias Bankingengine.Accounts.Schemas.Account
  alias Bankingengine.Repo

  require Logger

  def fetch(account_id) do
    Logger.debug("fetch user by id #{inspect(account_id)}")

    case Repo.get(Account, account_id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

  def preload(account) do
    IO.inspect(account)
    IO.inspect(Repo.preload(account, [:user]))
  end

  @doc """
  Given a valid changeset it attempts to insert a new account.

  It might fail due to unique index, in this case it will return an error tuple.
  """
  @spec insert_new_account(Inputs.Create.t()) ::
          {:ok, Account.t()} | {:error, Ecto.Changeset.t()}
  def insert_new_account(%Inputs.Create{} = input) do
    Logger.info("Inserting new account")

    params = %{agency: input.agency, number: input.number, balance: 100_000, user: input.user}

    with %{valid?: true} = changeset <- Account.changeset(params),
         {:ok, account} <- Repo.insert(changeset) do
      Logger.info("Account successfully inserted.")
      {:ok, account}
    else
      %{valid?: false} = changeset ->
        Logger.info("Error inserting new account. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  rescue
    Ecto.ConstraintError ->
      Logger.info("some unique field already taken")
      {:error, :unique_field_taken}
  end

  def transfer(from_changeset, to_changeset) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:from, from_changeset)
    |> Ecto.Multi.update(:to, to_changeset)
    |> Repo.transaction()
    |> case do
      {:ok, %{from: from, to: to}} ->
        {:ok, from, to}

      {:error, _} ->
        {:error, :unexpected_error}
    end
  end

  def update_account(_account_id, _new_data) do
    :ok
  end
end
