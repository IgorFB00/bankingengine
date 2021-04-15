defmodule Bankingengine.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid)
      add :agency, :string
      add :number, :string
      add :balance, :integer

      timestamps()
    end

    create unique_index(:accounts, [:agency, :number])
    create unique_index(:accounts, [:user_id])
  end
end
