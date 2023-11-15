defmodule DistributedLogV3Web.Router do
  use DistributedLogV3Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DistributedLogV3Web do
    pipe_through :api
  end
end
