defmodule Micro.PostTest do
  use ExUnit.Case, async: true

  alias Micro.Post

  @required_attributes %{
    content: Faker.Lorem.sentence()
  }

  @long_slug_parameters %{
    content: Faker.Lorem.sentence(),
    slug: Faker.Lorem.characters(26) |> to_string()
  }

  describe "changeset" do
    test "changeset without the required attributes" do
      changeset = Post.changeset(%Post{}, %{})
      refute changeset.valid?
    end

    test "changeset with required attributes" do
      changeset = Post.changeset(%Post{}, @required_attributes)
      assert changeset.valid?
    end

    test "changeset with slug longer than 25" do
      changeset = Post.changeset(%Post{}, @long_slug_parameters)
      refute changeset.valid?
    end
  end
end
