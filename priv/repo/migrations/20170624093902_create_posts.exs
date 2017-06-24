defmodule Micro.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :content, :text, null: false

      timestamps()
    end
  end
end
