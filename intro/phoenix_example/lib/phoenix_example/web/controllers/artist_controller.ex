defmodule PhoenixExample.Web.ArtistController do
  use PhoenixExample.Web, :controller

  alias PhoenixExample.Repo
  alias PhoenixExample.Schema.Artists

  plug :action

  def index(conn, _params) do
    json conn, Enum.map(Repo.all(Artists), fn(artist) -> %{id: artist.id, name: artist.name, gender: artist.gender} end)
  end

  def create(conn, %{"name" => name, "gender" => gender}) do
    artist = Repo.get_by(Artists, %{name: name, gender: gender})
    if artist != nil do
      json conn, %{id: artist.id, name: artist.name, gender: artist.gender}
    else
      changeset = Artists.changeset(%Artists{}, %{name: name, gender: gender})
      case Repo.insert(changeset) do
        {:ok, struct}       ->
          conn
          |> json %{id: struct.id, name: struct.name, gender: struct.gender}
        {:error, _} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json %{name: name, gender: gender}
      end
    end
  end

  def show(conn, %{"id" => id}) do
    artist = Repo.get(Artists, id)
    if artist != nil do
      conn
      |> json %{id: artist.id, name: artist.name, gender: artist.gender}
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end

  def update(conn, %{"id" => id, "name" => name, "gender" => gender}) do
    artist = Repo.get(Artists, id)
    if artist != nil do
      case Repo.update(Artists.changeset(artist, %{id: artist.id, name: name, gender: gender})) do
        {:ok, struct}       -> json conn, %{id: struct.id, name: struct.name, gender: struct.gender}
        {:error, _} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json %{id: artist.id, name: artist.name, gender: artist.gender}
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end

  def delete(conn, %{"id" => id}) do
    artist = Repo.get(Artists, id)
    if artist != nil do
      case Repo.delete(artist) do
         {:ok, struct}       -> json conn, %{id: struct.id, name: struct.name, gender: struct.gender}
         {:error, _} ->
           conn
           |> put_status(:unprocessable_entity)
           |> json %{id: artist.id, name: artist.name, gender: artist.gender}
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{message: "Not Found"}
    end
  end
end
