defmodule Tasktrack2Web.Router do
    use Tasktrack2Web, :router
  
    pipeline :browser do
      plug :accepts, ["html"]
      plug :fetch_session
      plug :fetch_flash
      plug :protect_from_forgery
      plug :put_secure_browser_headers
      plug Tasktrack2Web.Plugs.FetchSession
    end
  
    pipeline :api do
      plug :accepts, ["json"]
    end
  
    scope "/", Tasktrack2Web do
      pipe_through :browser # Use the default browser stack
  
      get "/", PageController, :index
      resources "/tasks", TaskController
      resources "/mytasks", TaskController
      resources "/taskreport", TaskController
      resources "/users", UserController
      resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    end
  
    # Other scopes may use custom stacks.
    # scope "/api", Tasktrack2Web do
    #   pipe_through :api
    # end
  end
  