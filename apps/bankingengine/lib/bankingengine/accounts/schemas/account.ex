defmodule Bankingengine.Accounts.Schemas.Account do
  @moduledoc """
  The entity of Account.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Bankingengine.Users.Schemas.User

  @required [:user, :agency, :number, :balance]
  @optional []

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    belongs_to :user, User
    field :agency, :string
    field :number, :string
    field :balance, :integer

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
