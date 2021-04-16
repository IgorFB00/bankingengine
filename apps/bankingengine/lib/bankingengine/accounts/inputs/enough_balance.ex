defmodule Bankingengine.Accounts.Inputs.EnoughBalance do
  @moduledoc """
  Input data for calling insert_new_user
  """
  use Ecto.Schema

  alias Bankingengine.Users.Schemas.User

  import Ecto.Changeset

  @required [:user, :agency, :number, :balance]
  @optional []

  @primary_key false
  embedded_schema do
    belongs_to :user, User
    field :agency, :string
    field :number, :string
    field :balance, :integer
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [:balance])
    |> IO.inspect()
    |> enough_balance()
    |> IO.inspect()
  end

  def enough_balance(%{valid?: false} = changeset) do
    changeset
  end

  def enough_balance(changeset) do
    balance = get_change(changeset, :balance)

    if balance < 0 do
      add_error(changeset, :not_enough_balance, "Not enough balance")
    else
      changeset
    end
  end
end
