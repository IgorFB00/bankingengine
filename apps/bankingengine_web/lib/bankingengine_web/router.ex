defmodule BankingengineWeb.Router do
  use BankingengineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingengineWeb do
    pipe_through :api

    get "/user", UsersController, :list
    post "/users", UsersController, :create
    get "/users/:id", UsersController, :show

  end
end
