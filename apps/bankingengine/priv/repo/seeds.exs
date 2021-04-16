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

alias Bankingengine.Users.Schemas.User
alias Bankingengine.Accounts.Schemas.Account
alias Bankingengine.Repo

Ecto.UUID.bingenerate()

user = %User{
  cpf: "3",
  name: "333",
  email: "34@teste.com.br",
  adress: "3"
}

account = %Account{
  user: user,
  agency: "1",
  number: "123",
  balance: 100_000
}

user2 = %User{
  cpf: "4",
  name: "444",
  email: "4@teste.com.br",
  adress: "4"
}

account2 = %Account{
  user: user2,
  agency: "2",
  number: "321",
  balance: 100_000
}

Repo.insert!(
  account,
  on_conflict: :nothing
)

Repo.insert!(
  account2,
  on_conflict: :nothing
)
