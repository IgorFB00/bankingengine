defmodule Bankingengine.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cpf, :string
      add :name, :string
      add :email, :string
      add :adress, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:cpf])
  end
end
