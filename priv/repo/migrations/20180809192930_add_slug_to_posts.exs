defmodule Micro.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add(:slug, :string, size: 25)
    end

    create(index(:posts, :slug, unique: true, where: "slug IS NOT NULL"))
  end
end
