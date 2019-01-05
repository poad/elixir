defmodule PhoenixExample.Schema.Artists do
  use Ecto.Schema
  import Ecto.Changeset


  schema "artists" do
    field :gender, :string, null: false
    field :name, :string, null: false
    has_many :musics, PhoenixExample.Schema.Musics
  end

  @doc false
  def changeset(artists, attrs) do
    artists
    |> cast(attrs, [:name, :gender])
    |> validate_required([:name, :gender])
  end
end
