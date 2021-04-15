# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bankingengine.Repo.insert!(%Bankingengine.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bankingengine.Schemas.User
alias Bankingengine.Repo

Repo.insert!(
  %User{
    cpf: "99999999999",
    name: "Igor",
    email: "meuemail@teste.com.br",
    adress: "meu endereço"
  },
  on_conflict: :nothing
)
