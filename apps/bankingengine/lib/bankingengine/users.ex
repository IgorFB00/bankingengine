defmodule Bankingengine.Users do
  @moduledoc """
  Domain public functions about the users context.
  """
  alias Bankingengine.Users.Inputs
  alias Bankingengine.Users.Schemas.User
  alias Bankingengine.Repo

  require Logger

  def fetch(user_id) do
    Logger.debug("fetch user by id #{inspect(user_id)}")

    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Given a valid changeset it attempts to insert a new user.

  It might fail due to unique index, in this case it will return an error tuple.
  """
  @spec insert_new_user(Inputs.Create.t()) ::
          {:ok, User.t()} | {:error, Ecto.Changeset.t() | :email_conflict}
  def insert_new_user(%Inputs.Create{} = input) do
    Logger.info("Inserting new user")

    params = %{name: input.name, email: input.email, cpf: input.cpf, adress: input.adress}

    with %{valid?: true} = changeset <- User.changeset(params),
         {:ok, user} <- Repo.insert(changeset) do
      Logger.info("User successfully inserted.")
      {:ok, user}
    else
      %{valid?: false} = changeset ->
        Logger.info("Error inserting new user. Error: #{inspect(changeset)}")
        {:error, changeset}
    end
  rescue
    Ecto.ConstraintError ->
      Logger.info("some unique field already taken")
      {:error, :unique_field_taken}
  end

  def update_user(_user_id, _new_data) do
    :ok
  end
end
