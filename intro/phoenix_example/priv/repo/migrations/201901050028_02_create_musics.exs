defmodule PhoenixExample.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add :name, :string, null: false
      add :genre, :string, null: false
      add :artists_id, references(:artists, on_delete: :nothing, null: false)
    end

    create unique_index :musics, [:name, :artists_id], name: :musics_unique_IDX

  end
end
