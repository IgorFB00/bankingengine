defmodule Bankingengine.Users do
  @moduledoc """
  Domain public functions about the users context.
  """
  alias Bankingengine.Inputs
  alias Bankingengine.Schemas.User
  alias Bankingengine.Repo

  require Logger

  @doc """
  Given a valid changeset it attempts to insert a new user.

  It might fail due to unique index, in this case it will return an error tuple.
  """
  @spec insert_new_user(Inputs.Create.t()) ::
          {:ok, User.t()} | {:error, Ecto.Changeset.t() | :email_conflict}
  def insert_new_user(%Inputs.Create{} = input) do
    Logger.info("Inserting new user")

    params = %{name: input.name, email: input.email, cpf: input.cpf, adress: input.adress}
    IO.puts("parametros:")
    IO.inspect(params)

    with %{valid?: true} = changeset <- User.changeset(params),
         {:ok, user} <- Repo.insert(IO.inspect(changeset)) do
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
