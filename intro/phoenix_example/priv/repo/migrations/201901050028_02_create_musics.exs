defmodule PhoenixExample.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add :name, :string, null: false
      add :genre, :string, null: false
      add :artists, references(:artists, on_delete: :nothing, null: false)
    end

    create index(:musics, [:artists])
  end
end
