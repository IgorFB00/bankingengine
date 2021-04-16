defmodule Bankingengine.Accounts.Inputs.Create do
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
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
