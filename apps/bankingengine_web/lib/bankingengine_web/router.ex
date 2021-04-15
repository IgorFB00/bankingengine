defmodule BankingengineWeb.Router do
  use BankingengineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingengineWeb do
    pipe_through :api

    post "/users", UserController, :create
  end
end
