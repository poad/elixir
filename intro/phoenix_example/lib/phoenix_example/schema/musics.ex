defmodule PhoenixExample.Schema.Musics do
  use Ecto.Schema
  import Ecto.Changeset


  schema "musics" do
    field :genre, :string, null: false
    field :name, :string, null: false
    belongs_to :artists, PhoenixExample.Schema.Artists
  end

  @doc false
  def changeset(musics, attrs) do
    musics
    |> cast(attrs, [:name, :genre, :artists_id])
    |> validate_required([:name, :genre, :artists_id])
  end
end
