defmodule PhoenixExample.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string, null: false
      add :gender, :string, null: false
    end

    create unique_index :artists, [:name, :gender], name: :artists_unique_IDX

  end
end
