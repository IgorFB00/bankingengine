defmodule Bankingengine.Inputs.Create do
  @moduledoc """
  Input data for calling insert_new_user
  """
  use Ecto.Schema

  import Ecto.Changeset

  @required [:cpf, :name, :email, :adress, :email_confirmation]
  @optional []

  @primary_key false
  embedded_schema do
    field :cpf, :string
    field :name, :string
    field :email, :string
    field :adress, :string

    field :email_confirmation, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/^[^@\s]+@[^@\s]+\.[^@\s]+$/)
    |> validate_format(:email_confirmation, ~r/^[^@\s]+@[^@\s]+\.[^@\s]+$/)
    |> validate_email_confirmation_match()
  end

  defp validate_email_confirmation_match(%{valid?: false} = changeset) do
    changeset
  end

  defp validate_email_confirmation_match(changeset) do
    email = get_change(changeset, :email)
    confirmation = get_change(changeset, :email_confirmation)

    if email == confirmation do
      changeset
    else
      add_error(changeset, :email_confirmation_match, "Email and confirmation must be the same")
    end
  end
end
