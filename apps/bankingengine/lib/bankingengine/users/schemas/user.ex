defmodule Bankingengine.Users.Schemas.User do
  @moduledoc """
  The entity of User.
  """
  use Ecto.Schema

  import Ecto.Changeset

  @required [:cpf, :name, :email, :adress]
  @optional []

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :cpf, :string
    field :name, :string
    field :email, :string
    field :adress, :string

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/^[^@\s]+@[^@\s]+\.[^@\s]+$/)
  end
end
