defmodule Bankingengine.Accounts.Schemas.Account do
  @moduledoc """
  The entity of Account.
  """
  use Ecto.Schema

  alias Bankingengine.Users.Schemas.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    belongs_to :user, User
    field :agency, :string
    field :number, :string
    field :balance, :integer

    timestamps()
  end
end
