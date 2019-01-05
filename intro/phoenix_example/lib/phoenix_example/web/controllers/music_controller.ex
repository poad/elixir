defmodule PhoenixExample.Web.MusicController do
  use PhoenixExample.Web, :controller

  alias PhoenixExample.Repo

  plug :action

  def index(conn, _params) do
    render conn, musics: Repo.all(PhoenixExample.Schema.Musics)
  end

  def create(conn, %{"name" => name, "genre" => genre, "artist" => artist}) do
    ret = case Repo.insert(%PhoenixExample.Schema.Musics{name: name, genre: genre, artists: artist}) do
      {:ok, struct}       -> %{id: struct.id, name: struct.name, genre: struct.genre}
      {:error, changeset} -> changeset
    end
    json conn, ret
  end
end
