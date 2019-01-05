defmodule PhoenixExample.Web.Router do
  use PhoenixExample.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :put_secure_browser_headers
  end

  scope "/", PhoenixExample.Web do
    pipe_through :api

    resources "/artists", ArtistController, except: [:new, :edit]

    resources "/musics", MusicController, except: [:new, :edit]
  end

end
