defmodule PhoenixExample.Web.MusicController do
  use PhoenixExample.Web, :controller

  alias PhoenixExample.Repo
  alias PhoenixExample.Schema.Musics

  plug :action

  def index(conn, _params) do
    json conn, Enum.map(Repo.all(Musics), fn(music) -> %{id: music.id, name: music.name, genre: music.genre, artist: music.artists} end)
  end

  def create(conn, %{"name" => name, "genre" => genre, "artist" => artist}) do
    case Repo.insert(%Musics{name: name, genre: genre, artists: artist}) do
      {:ok, struct}       -> json conn, %{id: struct.id, name: struct.name, genre: struct.genre}
      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json %{name: name, genre: genre, artists: artist}
    end
  end

  def show(conn, %{"id" => id}) do
    music = Repo.get(Musics, id)
    if music != nil do
      conn
      |> json %{id: music.id, name: music.name, gender: music.gender}
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end

  def update(conn, %{"id" => id, "name" => name, "genre" => genre}) do
    music = Repo.get(Musics, id)
    if music != nil do
      case Repo.update(Musics.changeset(music, %{id: music.id, name: name, genre: genre})) do
        {:ok, struct}       -> json conn, %{id: struct.id, name: struct.name, genre: struct.genre}
        {:error, _} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json %{id: music.id, name: music.name, gender: music.genre}
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end

  def delete(conn, %{"id" => id}) do
    music = Repo.get(Musics, id)
    if music != nil do
      case Repo.delete(music) do
        {:ok, struct}       -> json conn, %{id: struct.id, name: struct.name, genre: struct.genre}
        {:error, _} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json %{id: music.id, name: music.name, gender: music.genre}
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end

end
