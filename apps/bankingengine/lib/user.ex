defmodule Bankingengine.Users.Schemas.User do
  @moduledoc """
  The entity of User.
  """
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :cpf, :string
    field :name, :string
    field :email, :string
    field :adress, :string

    timestamps()
  end
end
