defmodule Wimf.Router do
  use Wimf.Web, :router

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

  scope "/", Wimf do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Wimf do
    pipe_through :api

    # RESTful resources
    resources "/exam_times", ExamTimeController, except: [:new, :edit]

    # Special route for Twillio webhook
    post "/webhooks/texts/incoming", SMSController, :incoming
  end
end
