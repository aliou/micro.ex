defmodule Micro.ChangesetTest do
  use ExUnit.Case, async: true

  defmodule Post do
    use Ecto.Schema

    schema "posts" do
      field :slug, :string
    end

    def changeset(post, params \\ %{}) do
      post
      |> Ecto.Changeset.cast(params, [:slug])
      |> Micro.Changeset.nullable_unique_constraint(:slug)
    end
  end

  describe "nullable_unique_constraint/3" do
    test "it returns the changeset without changes when the field is nil in the struct" do
      original_changeset = Ecto.Changeset.change(%Post{}, %{slug: nil})
      changeset = Post.changeset(original_changeset, %{})

      assert changeset.constraints == []
    end

    test "it returns the changeset without changes when the field is nil in the params" do
      original_changeset = Ecto.Changeset.change(%Post{}, %{})
      changeset = Post.changeset(original_changeset, %{slug: nil})

      assert changeset.constraints == []
    end

    test "it returns the changeset with the unique constraint when the field is defined" do
      slug = Faker.Lorem.word()
      original_changeset = Ecto.Changeset.change(%Post{}, %{slug: slug})
      changeset = Post.changeset(original_changeset, %{})

      refute changeset.constraints == []
      assert length(changeset.constraints) == 1

      constraint = changeset.constraints |> List.first()

      assert %{field: :slug, type: :unique} = constraint
    end
  end
end
