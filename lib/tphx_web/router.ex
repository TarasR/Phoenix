defmodule TphxWeb.Router do
  use TphxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TphxWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/products", ProductController
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    #get "/products", ProductsController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", TphxWeb do
  #   pipe_through :api
  # end
end
