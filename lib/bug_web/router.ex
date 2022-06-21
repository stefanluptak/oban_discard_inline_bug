defmodule BugWeb.Router do
  use BugWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BugWeb do
    pipe_through :api
  end
end
